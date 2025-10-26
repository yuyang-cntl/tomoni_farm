class Public::CheckoutsController < ApplicationController
  before_action :authenticate_customer!

  def create
    item = Item.find(params[:item_id])
    quantity = params[:amount].to_i

    if quantity <= 0
      redirect_to new_public_order_path, alert: "数量は1以上を指定してください" and return
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'jpy',
          product_data: {
            name: item.name,
          },
          unit_amount: item.price,
        },
        quantity: quantity,
      }],
      mode: 'payment',
      success_url:"#{request.base_url}#{complete_public_orders_path}",
      cancel_url: "#{request.base_url}#{new_public_order_path}"
    )
    redirect_to session.url, allow_other_host: true
  end
end