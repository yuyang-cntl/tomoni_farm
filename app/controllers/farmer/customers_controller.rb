class Farmer::CustomersController < ApplicationController
  before_action :authenticate_farmer!
  def index
    @customers = current_farmer.customers
    @customer = Customer.new
  end

  def show
    @customer = current_farmer.customer.find(params[:id])
  end

  def edit
    @customer = current_farmer.customer.find(params[:id])
  end

  def update
    @customer = current_farmer.customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to farmer_customer_path(@customer),notice:"情報を更新しました"
    else
      render :edit
    end
  end
end
