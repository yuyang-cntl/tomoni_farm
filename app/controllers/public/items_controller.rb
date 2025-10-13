class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @items = Item.includes(images_attachments: :blob).where(is_active: true)
  end

  def show
    @item = Item.find(params[:id])
  end

  def calendar_events
    item = Item.find(params[:id])
    if item.harvest_start && item.harvest_end
      events = [{
        title: item.name,
        start: item.harvest_start,
        end: item.harvest_end,
        url: public_item_path(item),
        color: color_for(item)
      }]
      render json: events
    else
      render json: []
    end
  end

  private

  def color_for(item)
    "#28a745"
  end

  
end
