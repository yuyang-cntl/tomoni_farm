class Farmer::OrdersController < ApplicationController
  before_action :authenticate_farmer!
  def show
    @farmer = current_farmer
    @customer = @farmer.followers.find_by(params[:customer_id])
    @order = @customer.orders.find_by(params[:id])
    @item = Item.find(@order.item_id)
    @postal_code = @order.postal_code
    @address = @order.address
    @shipping_name = @order.shipping_name
    @amount = @order.amount
    @shipping_cost = 500
    @grand_total = @order.grand_total
    render :show
  end

  def update
  end
end
