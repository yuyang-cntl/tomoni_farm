class Farmer::OrdersController < ApplicationController
  before_action :authenticate_farmer!
  
  def show
    @farmer = current_farmer
    @customer = @farmer.followers.find_by(id: params[:customer_id])
    @order = @customer.orders.find_by(id: params[:id])
    @order_details = @order.order_details.includes(:item)
    @shipping_cost = 500
    @postal_code = @order.postal_code
    @address = @order.address
    @shipping_name = @order.shipping_name
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
        NotificationService.notify(
          recipient: @order.customer,
          actor: current_farmer,
          notifiable: @order,
          notification_key: "update_status"
          )
      redirect_to farmer_profile_path, notice: "ステータスを更新しました"
    else
      redirect_to farmer_profile_path, alert: "更新に失敗しました"
    end
  end
  
  def order_params
    params.require(:order).permit(
      :customer_id,
      :address,
      :status,
      order_details_attributes: [:item_id, :amount, :price]  
    )
  end

end
