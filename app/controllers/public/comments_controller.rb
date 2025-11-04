class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @comment = Comment.new
  end

  def create
    @diary = Diary.find(params[:diary_id])
    @post = @diary.posts.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.customer = current_customer

    if @comment.save
      redirect_to public_farmer_diary_post_path(@diary.farmer_id, @diary.id, @post.id), notice: "コメントを投稿しました"
    else
      flash.now[:alert] = "コメントの投稿に失敗しました"  
      render 'public/posts/show'
    end
  end

  def destroy
    diary = Diary.find(params[:diary_id])
    post = diary.posts.find(params[:post_id])
    comment = post.comments.find(params[:id])
    comment.destroy
    redirect_to public_farmer_diary_post_path(diary.farmer_id, diary.id, post.id),notice:"コメントを削除しました"
  end

private
  
  def comment_params
   params.require(:comment).permit(:body)
  end

end
