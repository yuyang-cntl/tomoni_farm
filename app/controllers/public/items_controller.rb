class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @items = Item.includes(images_attachments: :blob).where(is_active: true)
  end

  def show
    @item = Item.find(params[:id])
  end
end
