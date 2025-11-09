class Public::WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :redirect_guest_to_root

  def create
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = ENV['STRIPE_WEBHOOK_SECRET']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError, Stripe::SignatureVerificationError => e
      Rails.logger.error("Stripe webhook error: #{e.message}")
      head :bad_request and return
    end

    if event.type == "checkout.session.completed"
     session = event.data.object
     customer = Customer.find_by(id: session.client_reference_id)
     return head :ok unless customer

     item_id = session.metadata.item_id
     amount = session.metadata.amount.to_i

     begin
      ApplicationRecord.transaction do
        Rails.logger.info("✅ Webhook received client_reference_id: #{session.client_reference_id}")

       save_address_from_metadata(session) 
       order = create_order(session, item_id, amount)
       session_with_expand = Stripe::Checkout::Session.retrieve({ id: session.id, expand: ["line_items"] })
       session_with_expand.line_items.data.each do |line_item|
         create_order_detail(order, line_item, item_id)
       end
      end
      rescue => e
       Rails.logger.error("Order creation failed: #{e.message}")
       head :internal_server_error and return
      end
     end
    head :ok
  end

  private

  def save_address_from_metadata(session)
    Address.find_or_create_by!(
      customer_id: session.client_reference_id,
      postal_code: session.metadata["postal_code"],
      address: session.metadata["address"],
      shipping_name: session.metadata["shipping_name"]
    )
  end

  def create_order(session, item_id, amount)
    customer_details = session.customer_details
    address = customer_details&.address
    Order.create!(
                    customer_id: session.client_reference_id,
                    item_id: item_id,
                    amount: amount,
                    shipping_name: session.metadata["shipping_name"],
                    postal_code: session.metadata["postal_code"],
                    address: session.metadata["address"],
                    shipping_cost: 500,
                    grand_total: session.amount_total,
                    payment_method: :credit_card,
                    status: :confirmed,
                    payment_intent_id: session.payment_intent
                 )
  end

  def create_order_detail(order, line_item, item_id)
    item = Item.find_by(id: item_id)
    return unless item
  
    order.order_details.create!(
      item_id: item.id,
      customer_id: order.customer_id,
      amount: line_item.quantity,
      price: line_item.price.unit_amount,
    )
    farmer = item.farmer
    unless order.customer.followed_farmers.include?(farmer)
      order.customer.followed_farmers << farmer
    end

    NotificationService.notify(
      recipient: farmer,
      actor: order.customer,
      notifiable: order,
      notification_key: "order_received"
    )
  end

end