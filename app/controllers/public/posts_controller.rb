class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    farmer_diary = current_customer.farmer_diary
    @post = farmer_diary.posts.find(params[:id])
  end
end
