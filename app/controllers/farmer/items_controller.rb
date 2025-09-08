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
    @item = Item.new
  end

  def show
    @item = current_farmer.items.find(params[:id])
  end

  def edit
    @item = current_farmer.items.find(params[:id])
  end

  def update
    @item = current_farmer.items.find(params[:id])
    if @item.update(item_params)
      redirect_to farmer_item_path(@item),notice:"情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    item = current_farmer.items.find(params[:id])
    item.destroy
    redirect_to farmer_items_path,notice:"商品を削除しました"
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :introduction, :harvest_time,
      :price, :is_active, images:[] )
  end

end
