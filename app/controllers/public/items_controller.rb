class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    if current_customer.farmer_items.present?
    @items = current_customer.farmer_items.includes(images_attachments: :blob)
    else
      @items = []
    end
  end

  def show
    @item = current_customer.farmer_items.find(params[:id])
  end
end
