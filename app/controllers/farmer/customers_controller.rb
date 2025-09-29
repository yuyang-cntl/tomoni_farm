class Farmer::CustomersController < ApplicationController
  before_action :authenticate_farmer!
  def index
    @farmer = current_farmer
    @customers = @farmer.followers
    @customer = Customer.new
  end

  def show
    @farmer = current_farmer
    @customer = @farmer.followers.find_by(params[:customer_id])
    @orders = @customer.orders.page(params[:page]).per(10)
  end

  def edit
    @farmer = current_farmer
    @customer = @farmer.followers.find(params[:id])
  end

  def update
    @customer = current_farmer.customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to farmer_customer_path(@customer),notice:"情報を更新しました"
    else
      render :edit
    end
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to farmer_profile_path, notice: "ステータスを更新しました"
    else
      redirect_to farmer_profile_path, alert: "更新に失敗しました"
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
  
end
