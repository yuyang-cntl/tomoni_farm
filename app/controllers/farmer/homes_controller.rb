class Farmer::HomesController < ApplicationController
  before_action :authenticate_farmer!

  def top
    @farmer = current_farmer
    @customer = @farmer.followers.find_by(id: params[:customer_id])

    @orders = if @customer.present?
      @customer.orders.page(params[:page]).per(10)
    else
      Order.none.page(params[:page]).per(10)
    end
  end
end
