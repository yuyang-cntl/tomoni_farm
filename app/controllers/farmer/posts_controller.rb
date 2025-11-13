class Farmer::PostsController < ApplicationController
  before_action :authenticate_farmer!
  def new
    @diary = current_farmer.diaries.find(params[:diary_id])
    @post = Post.new
  end

  def create
    @diary = current_farmer.diaries.find(params[:diary_id])
    @post = @diary.posts.build(post_params)
    @post.farmer = current_farmer
    if @post.save
      Customer.find_each do|customer|
        NotificationService.notify(
          recipient: customer,
          actor: @post.farmer,
          notifiable: @post,
          notification_key: "new_post"
          )
      end
     redirect_to farmer_diary_post_path(@diary,@post), notice: "日記に投稿しました"
    else
      render :new
    end
  end

  def index
    @diary = current_farmer.diaries.find(params[:diary_id])
    @posts = @diary.posts.includes(images_attachments: :blob)
    @post = Post.new
  end

  def show
    @comment = Comment.new
    @diary = current_farmer.diaries.find_by(id: params[:diary_id])
    @post = @diary.posts.find(params[:id])
    @customer = current_farmer.customers.find_by(id: params[:customer_id])
    if @customer.present?
    @post.comment = customer.post_comment(params[:id])
    end
    @comments = @post.comments
    @feedback = CustomerFeedbackClient.generate(post: @post, comments: @comments)
  end

  def edit
    @diary = current_farmer.diaries.find(params[:diary_id])
    @post = @diary.posts.find(params[:id])
  end

  def update
    @diary = current_farmer.diaries.find(params[:diary_id])
    @post = @diary.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to farmer_diary_post_path(@diary,@post), notice: "投稿を更新しました"
    else
      render :edit
    end
  end

  def destroy
    diary = current_farmer.diaries.find(params[:diary_id])
    post = diary.posts.find(params[:id])
    post.destroy
    redirect_to farmer_diary_posts_path(diary),notice:"投稿を削除しました"
  end

  private

  def post_params
    params.require(:post).permit(
      :title, :body,
      images:[],
      videos:[]
      )
  end

end
