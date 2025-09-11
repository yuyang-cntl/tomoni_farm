class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @address = Address.new
  end

  def create
    @address = current_customer.addresses.build(address_params)
    if @address.save
    redirect_to public_addresses_path, notice: "配送先を登録しました"
    else
      render :new
    end
  end

  def index
    @addresses = current_customer.addresses.all
    @address = Address.new
  end

  def edit
    @address = current_customer.addresses.find(params[:id])
  end

  def show
    @address = current_customer.addresses.find(params[:id])
  end

  def update
    @address = current_customer.addresses.find(params[:id])
    if @address.update(address_params)
      redirect_to public_addresses_path(@address),notice:"情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    address = current_customer.addresses.find(params[:id])
    address.destroy
    redirect_to public_addresses_path,notice:"配送先を削除しました"
  end

private

  def address_params
    params.require(:address).permit(
    :shipping_name, :postal_code, :address )
  end

end