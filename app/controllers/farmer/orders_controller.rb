class Farmer::OrdersController < ApplicationController
  before_action :authenticate_farmer!
  def show
    @farmer = current_farmer
    @customer = @farmer.followers.find_by(id: params[:customer_id])
    @order = @customer.orders.find_by(params[:id]) 
    @item = Item.find(@order.item_id)
    @postal_code = @order.postal_code
    @address = @order.address
    @shipping_name = @order.shipping_name
    @amount = @order.amount
    @shipping_cost = 500
    @grand_total = @order.grand_total
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to farmer_profile_path, notice: "ステータスを更新しました"
    else
      redirect_to farmer_profile_path, alert: "更新に失敗しました"
    end
  end

  def order_params
    params.require(:order).permit(:status)
  end

end