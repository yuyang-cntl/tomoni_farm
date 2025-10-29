class Public::CheckoutsController < ApplicationController
  before_action :authenticate_customer!

  def create
    item = Item.find(params[:item_id])
    quantity = params[:amount].to_i
    stripe_customer = Stripe::Customer.create(email: current_customer.email)

    if quantity <= 0
      redirect_to new_public_order_path, alert: "数量は1以上を指定してください" and return
    end

    session = Stripe::Checkout::Session.create(
      customer: stripe_customer.id,
      client_reference_id: current_customer.id,
      mode: 'payment',
      payment_method_types: ['card'],
      metadata: {
        item_id: item.id.to_s,
        amount: quantity.to_s,
        address: params[:address].to_s,
        postal_code: params[:postal_code].to_s,
        shipping_name: params[:shipping_name].to_s
      },
      line_items: [{
        price_data: {
          currency: 'jpy',
          product_data: {
            name: item.name
          },
          unit_amount: item.price
        },
        quantity: quantity,
        }],
        shipping_options: [{
            shipping_rate_data: {
              type: "fixed_amount",
              fixed_amount: {
                amount: 500,
                currency: "jpy"
              },
              display_name: "送料一律"
            }
          }],
      success_url: "#{request.base_url}#{complete_public_orders_path}",
      cancel_url: "#{request.base_url}#{new_public_order_path}"
    )
    redirect_to session.url, allow_other_host: true
  end
end