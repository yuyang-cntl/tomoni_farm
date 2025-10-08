class Farmer::LikesController < ApplicationController
  def index
    @diary = current_farmer.diaries.find(params[:diary_id])
    @post = @diary.posts.find(params[:post_id])
    @likes = @post.likes.includes(customer: {profile_image_attachment: :blob})
  end
end
