class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    @diary = Diary.find(params[:diary_id])
    @post = @diary.posts.find(params[:id])
    @customer = current_customer
    @comment = Comment.new
  end

  def index
    start_date = parse_date(params[:start_date])
    end_date = parse_date(params[:end_date])

    if start_date.nil? || end_date.nil? || start_date > end_date
      flash[:alert] = I18n.t("errors.invalid_date_range")
      redirect_to request.referer || root_path
      return
    end

      @diary = Diary.find(params[:diary_id])
      @posts = @diary.posts.within_period(start_date, end_date)

      render :index
  end

  private

  def parse_date(date_str)
    Date.parse(date_str) rescue nil
  end

end
