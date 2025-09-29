class Public::SearchController < ApplicationController
  def search
    case params[:target]
    when "farmer"
      @farmers = Farmer.where("name LIKE ?", "%#{params[:q]}%")
      render "public/farmers/search"
    when "diary"
      @diaries = Diary.where("title LIKE ?", "%#{params[:q]}%")
      render "public/diaries/search"
    when "item"
      @items = Item.where("name LIKE ?", "%#{params[:q]}%")
      render "public/items/search"
    else
      redirect_to root_path, alert: "検索対象が不明です"
    end
  end
end