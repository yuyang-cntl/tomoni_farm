class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
    @item = Item.find(params[:item_id])
    @amount = params[:amount].to_i
  end

  def confirm
    @order = Order.new(order_params)
    @item = Item.find(@order.item_id)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.shipping_name = @address.name
    @order.amount = params[:order][:amount].to_i
    @order.shipping_cost = 500
    @order.grand_total = (@item.price * @order.amount) + @order.shipping_cost  
  end

  def complete
  end

  def create
    @order = Order.new
    @order = current_customer.orders.build(order_params)
    if params[:order][:address_type] == "existing"
    elsif params[:order][:address_type] == "new"
    end

    if @order.save
     redirect_to public_order_confirm_path
    else
      render :new
    end
  end

  def index
  end

  def show
    @order = current_customer.orders.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:item_id, :amount, :payment_method, :postal_code, :address, :shipping_name)
  end

end
