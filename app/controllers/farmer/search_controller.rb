class Farmer::SearchController < ApplicationController
  def search
    case params[:target]
    when "customer"
      @customers = Customer.where("CONCAT(last_name, ' ', first_name) LIKE ?", "%#{params[:q]}%")
      render "farmer/customers/search"
    when "diary"
      @diaries = Diary.where("title LIKE ?", "%#{params[:q]}%")
      render "farmer/diaries/search"
    when "item"
      @items = Item.where("name LIKE ?", "%#{params[:q]}%")
      render "farmer/items/search"
    else
      redirect_to root_path, alert: "検索対象が不明です"
    end
  end
end
