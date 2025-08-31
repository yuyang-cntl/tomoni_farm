class Farmer::ItemsController < ApplicationController
  before_action :authenticate_farmer!

  def new
    @item = Item.new
  end

  def create
    @item = current_farmer.items.build(item_params)
    if @item.save
    redirect_to farmer_items_path, notice: "商品を登録しました"
    else
      render :new
    end
  end

  def index
    @items = current_farmer.items.includes(images_attachments: :blob)
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
      :name, :introduction, :harvest_time,
      :price, :is_active, images:[] )
  end

end
