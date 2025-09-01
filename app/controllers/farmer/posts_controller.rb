class Farmer::PostsController < ApplicationController
  before_action :authenticate_farmer!
  def new
    @post = Post.new
  end

  def create
    @post = current_farmer.diaries.build(diary_params)
    if @diary.save
    redirect_to farmer_diaries_path, notice: "日記を投稿しました"
    else
      render :new
    end
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
