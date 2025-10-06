class Farmer::OrderDetailsController < ApplicationController
  before_action :authenticate_farmer!

  def show
    @farmer = current_farmer
    @customer = @farmer.followers.find_by(id: params[:customer_id])
    @order = @customer.orders.find_by(id: params[:id]) 
    @order_details = @order.order_details.includes(:item)
    @shipping_cost = 500
  end
  
  def update
  end
end
