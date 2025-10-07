class Public::SearchController < ApplicationController
  def search
    case params[:target]
    when "farmer"
      @farmers = Farmer.where("name LIKE ?", "%#{params[:q]}%")
      render "public/farmers/search"
    when "diary"
      followed_farmer_ids = current_customer.followed_farmers.pluck(:id)
      @diaries = Diary.where(farmer_id: followed_farmer_ids)
                      .where("title LIKE ?", "%#{params[:q]}%")
      render "public/diaries/search"
    when "item"
      @items = Item.where("name LIKE ?", "%#{params[:q]}%")
      render "public/items/search"
    else
      redirect_to root_path, alert: "検索対象が不明です"
    end
  end
end