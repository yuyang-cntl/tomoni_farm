class Public::CommentsController < ApplicationController
  def new
    @comment = comment.new
  end

  def create
    post = Post.find(params[:current_customer.farmer_post_id])
    @comment = current_customer.farmer.comment.build(comment_params)
    @comment.post_id = post.id
    if @comment.save
    redirect_to farmer_post_comment_path(current_customer.farmer,post,@comment), notice: "コメントを投稿しました"
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
