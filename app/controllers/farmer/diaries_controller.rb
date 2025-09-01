class Farmer::DiariesController < ApplicationController
  def new
    @diary = Diary.new
  end

  def create
    @diary = current_farmer.diaries.build(diary_params)
    if @diary.save
    redirect_to farmer_diaries_path, notice: "日記を投稿しました"
    else
      render :new
    end
  end

  def index
    @diaries = current_farmer.diaries.includes(images_attachments: :blob)
    @diary = Diary.new
  end

  def show
    @diary = current_farmer.diaries.find(params[:id])
  end

  def edit
    @diary = current_farmer.diaries.find(params[:id])
  end

  def update
    @diary = current_farmer.diaries.find(params[:id])
    if @diary.update(diary.params)
      redirect_to farmer_diary_path(@diary),notice:"日記を更新しました"
    else
      render :edit
    end
  end

  def destroy
    diary = current_farmer.diaries.find(params[:id])
    diary.destroy
    redirect_to farmer_diaries_path,notice:"日記を削除しました"
  end

  private

  def diary_params
    params.require(:diary).permit(
      :title, :body, images:[] )
  end
  
end
