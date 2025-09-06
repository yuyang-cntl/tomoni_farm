class Public::DiariesController < ApplicationController
  def index
<<<<<<< HEAD
  end

  def show
=======
    diary = current_customer.farmer.diaries
    @diaries = @diary.all
  end

  def show
    farmer = current_customer.farmer
    @diary = farmer.diaries.find(params[:id])
>>>>>>> 5f72503 (likes_controller)
  end
end
