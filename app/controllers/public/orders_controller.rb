class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
    @order.customer = current_customer
    @item = Item.find(params[:item_id])
    @amount = params[:amount].to_i
  end

  def confirm
    @order = Order.new(order_params)
    @item = Item.find(@order.item_id)
    @amount = @order.amount.to_i
    @address_type = params[:order][:address_type]
    @selected_payment_method = params[:order][:payment_method]

    if @address_type == "existing"
      address_id = params[:order][:address_id]
      if address_id.present?
        @address = Address.find(address_id)
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.shipping_name = @address.shipping_name
      else
        flash.now[:alert] = "住所を選択してください"
        render :new and return
      end
    elsif @address_type == "new"
      saved_address = save_new_address(params[:order])

      if saved_address.persisted?
        @order.postal_code = saved_address.postal_code
        @order.address = saved_address.address
        @order.shipping_name = saved_address.shipping_name
      else
        flash[:error] = "住所の保存に失敗しました: #{saved_address.errors.full_messages.join(', ')}"
        render :new and return
      end
    end

    @order.shipping_cost = 500
    @order.grand_total = (@item.price * @order.amount) + @order.shipping_cost
    render :confirm
  end

  def create
    @order = current_customer.orders.build(order_params)
    @item = Item.find(@order.item_id)
    @amount = @order.amount
    address_type = params[:order][:address_type]

    if address_type == "existing"
      address = Address.find(params[:order][:address_id])
      @order.postal_code = address.postal_code
      @order.address = address.address
      @order.shipping_name = address.shipping_name

    elsif address_type == "new"
      saved_address = save_new_address(params[:order])
      if saved_address.persisted?
        @order.postal_code = saved_address.postal_code
        @order.address = saved_address.address
        @order.shipping_name = saved_address.shipping_name
      else
        flash[:error] = "住所の保存に失敗しました: #{saved_address.errors.full_messages.join(', ')}"
        render :new and return
      end
    end

    @order.shipping_cost = 500
    @order.grand_total = (@item.price * @amount) + @order.shipping_cost

    if @order.save
    detail = OrderDetail.new(
      order_id: @order.id,
      item_id: @order.item_id,
      customer_id: current_customer.id,
      amount: @amount,
      price: @item.price,
      status: @item.status
    )

    if detail.save
      farmer = @item.farmer
      unless current_customer.followed_farmers.include?(farmer)
        current_customer.followed_farmers << farmer
      end
      NotificationService.notify(
        recipient: farmer,
        actor: current_customer,
        notifiable: @order,
        notification_key: "order_received"
      )
      flash[:notice] = "ご注文が完了しました、生産者の投稿がご覧になれます"
      redirect_to complete_public_orders_path
    else
      flash[:alert] = "お届け先を入力してください"
      render :new
    end
    else
      flash[:alert] = "お届け先を入力してください"
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
  end

  def destroy
    order = current_customer.orders.find(params[:id])
    farmer = order.order_details.first&.item&.farmer

    order.destroy

    NotificationService.notify(
      recipient: farmer,
      actor: current_customer,
      notifiable: order,
      notification_key: :order_deleted
    )
    redirect_to public_orders_path, notice:"注文を削除しました"
  end

  private

  def order_params
    params.require(:order).permit(
      :item_id, :amount, :payment_method, :postal_code, 
      :address, :shipping_name, :shipping_cost, :grand_total
      )
  end

  def save_new_address(params)
    existing_address = Address.find_by(
      customer_id: current_customer.id,
      postal_code: params[:postal_code],
      address: params[:address],
      shipping_name: params[:shipping_name]
    )
  
    return existing_address if existing_address.present?
  
    new_address = Address.new(
      customer_id: current_customer.id,
      postal_code: params[:postal_code],
      address: params[:address],
      shipping_name: params[:shipping_name]
    )

    new_address.save
    new_address
  end
end