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
    @order.shipping_name = @address.shipping_name
    @order.amount = params[:order][:amount].to_i
    @order.shipping_cost = 500
    @order.grand_total = (@item.price * @order.amount) + @order.shipping_cost
    render :confirm 
  end

  def complete
  end

  def create
    @order = current_customer.orders.build(order_params)
    @item = Item.find(@order.item_id)
    if params[:order][:address_type] == "existing"
    elsif params[:order][:address_type] == "new"
    end

    if @order.save
    detail = OrderDetail.new(
      order_id: @order.id,
      item_id: @order.item_id,
      customer_id: current_customer.id,
      amount: @order.amount,
      price: @item.price,
      status: @item.status
    )

    if detail.save
      farmer = @item.farmer
      unless current_customer.followed_farmers.include?(farmer)
        current_customer.followed_farmers << farmer
      end
      puts "注文と生産者のフォローが完了しました: #{detail.inspect}"
      redirect_to complete_public_orders_path
    else
      puts "注文失敗: #{detail.errors.full_messages}"
      render :new
    end
    else
      puts "注文失敗: #{@order.errors.full_messages}"
      render :new
    end
  end

  def index
    @orders = current_customer.orders.page(params[:page]).per(10)
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @item = Item.find(@order.item_id)
    @postal_code = @order.postal_code
    @address = @order.address
    @shipping_name = @order.shipping_name
    @amount = @order.amount
    @shipping_cost = 500
    @grand_total = @order.grand_total
    render :show
  end

  private

  def order_params
    params.require(:order).permit(
      :item_id, :amount, :payment_method, :postal_code, 
      :address, :shipping_name, :shipping_cost, :grand_total
      )
  end

end
