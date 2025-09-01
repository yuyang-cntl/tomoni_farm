class Farmer::CustomersController < ApplicationController
  before_action :authenticate_farmer!
  def index
    @customers = current_farmer.customers
    @customer = Customer.new
  end

  def show
  end

  def edit
  end

  def update
  end
end
