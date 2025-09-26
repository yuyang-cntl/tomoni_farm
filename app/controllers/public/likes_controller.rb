class Public::LikesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @diary = Diary.find(params[:diary_id])
    @post = @diary.posts.find(params[:post_id])
    @customer = current_customer
    unless @post.liked_by?(current_customer)
      @post.likes.create(customer_id: current_customer.id)
    end
    redirect_to public_farmer_diary_post_path(@diary.farmer_id, @diary.id, @post.id)
  end

  def destroy
    diary = Diary.find(params[:diary_id])
    post = diary.posts.find(params[:post_id])
    like = post.likes.find_by(customer_id: current_customer.id)
    like.destroy if like.present?
    redirect_to public_farmer_diary_post_path(diary.farmer_id, diary.id, post.id)
  end
end
