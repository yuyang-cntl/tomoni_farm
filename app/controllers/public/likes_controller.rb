class Public::LikesController < ApplicationController
  def create
<<<<<<< HEAD
  end

  def destroy
=======
    post = Post.find(params[:post_id])
    like = current_customer.likes.new(post_id: post.id)
    like.save
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    like = current_customer.likes.find_by(post_id: post.id)
    like.destroy
    redirect_to post_path(post)
>>>>>>> 5f72503 (likes_controller)
  end
end
