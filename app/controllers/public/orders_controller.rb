class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    order = Order.new
  end

  def confirm
  end

  def complete
  end

  def create
    @order = current_customer.order.build(order_params)
    if @order.save
     redirect_to public_order_confirm_path
    else
      render :new
    end
  end

  def index
  end

  def show
  end
end
