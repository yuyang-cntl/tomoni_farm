class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    @diary = Diary.find(params[:diary_id])
    @post = @diary.posts.find(params[:id])
    @customer = current_customer
    @comment = Comment.new
  end
end
