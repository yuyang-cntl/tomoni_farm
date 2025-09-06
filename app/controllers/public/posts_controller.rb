class Public::PostsController < ApplicationController
  def show
<<<<<<< HEAD
=======
    farmer_diary = current_customer.farmer_diary
    @post = farmer_diary.posts.find(params[:id])
>>>>>>> 5f72503 (likes_controller)
  end
end
