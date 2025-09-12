class Public::DiariesController < ApplicationController
  
  def index
    @diaries = current_customer.followed_farmers.includes(:diaries).map(&:diaries).flatten
  end

  def show
    @diary = current_customer.followed_farmers.includes(:diaries)
            .map(&:diaries).flatten.find { |d| d.id == params[:id].to_i }
    unless @diary
      redirect_to public_farmer_diaries_path, alert: "注文し、生産者フォロー後に閲覧可能です"
      return
    end
    @posts = @diary.posts.order(created_at: :desc)
  end
end
