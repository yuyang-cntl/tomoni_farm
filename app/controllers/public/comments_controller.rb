class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @comment = comment.new
  end

  def created
    @diary = Diary.find(params[:diary_id])
    @post = @diary.posts.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.customer = current_customer

    if @comment.save
      redirect_to diary_post_path(@diary, @post), notice: "コメントを投稿しました"
    else
      render 'posts/show', alert: "コメントの投稿に失敗しました"
    end
  end

  def index
    @post = Post.find(params[:post_id])
    post = current_customer.farmer_post.find(params[:post_id])
    @comments = post.comments.includes(images_attachments: :blob)
    @comment = Comment.new
  end

  def show
    @post = current_customer.farmer_post.find(params[:post_id])
    @comment = @post.comment.find(params[:id])
    @comment = @post.comments.find(params[:id])
  end

  def destroy
    post = current_customer.farmer_post.find(params[:post_id])
    comment = post.comment.find(params[:id])
    comment.destroy
    redirect_to farmer_post_comment_path(current_customer.farmer,post,comment),notice:"コメントを削除しました"
  end

private
  
  def comment_params
   params.require(:comment).permit(:body)
  end

end
