class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @comment = comment.new
  end

  def create
    post = Post.find(params[:current_customer.farmer_post_id])
    @comment = current_customer.farmer.comment.build(comment_params)
    @comment.post_id = post.id
    if @comment.save
    redirect_to farmer_post_comment_path(current_customer.farmer,post,@comment), notice: "コメントを投稿しました"
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
    @comment = current_customer.comment.build(comment_params)
    @comment.post = post
    if @comment.save
      redirect_to diary_post_path(post.diary, post), notice: "コメントを投稿しました"
    else
      redirect_to diary_post_path(post.diary, post), alert: "コメントの投稿に失敗しました"
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
<<<<<<< HEAD
    @comment = @post.comment.find(params[:id])
=======
    @comment = @post.comments.find(params[:id])
>>>>>>> 5f72503 (likes_controller)
  end

  def destroy
    post = current_customer.farmer_post.find(params[:post_id])
    comment = post.comment.find(params[:id])
    comment.destroy
    redirect_to farmer_post_comment_path(current_customer.farmer,post,comment),notice:"コメントを削除しました"
  end

private
  
  def comment_params
   params.require(:comment).permit(:comment)
  end

end
