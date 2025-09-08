class Public::ItemsController < ApplicationController

  def index
    @items = Item.all.includes(images_attachments: :blob)
    @item = Item.new
  end

  def show
    @item = farmer_items.find(params[:id])
  end
end
