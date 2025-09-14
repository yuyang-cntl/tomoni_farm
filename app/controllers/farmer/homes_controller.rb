class Farmer::HomesController < ApplicationController
  before_action :authenticate_farmer!
  def top
    @farmer = current_farmer
    @customer = @farmer.followers.find_by(params[:customer_id])
    @orders = @customer.orders.page(params[:page]).per(10)
  end
end
