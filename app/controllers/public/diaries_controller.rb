class Public::DiariesController < ApplicationController
  
  def index
    diary = current_customer.farmer.diaries
    @diaries = @diary.all
  end

  def show
    farmer = current_customer.farmer
    @diary = farmer.diaries.find(params[:id])
  end
end
