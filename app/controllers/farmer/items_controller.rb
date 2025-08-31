class Farmer::ItemsController < ApplicationController
  before_action :authenticate_farmer!

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.farmer = current_farmer
    @item.save
    redirect_to farmer_items_path
  end

  def index
    @items = current_farmer.items
  end


  def show
    @item = current_farmer.items.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :introduction, :image, :harvest_time,
      :price, :is_active )
  end

end
