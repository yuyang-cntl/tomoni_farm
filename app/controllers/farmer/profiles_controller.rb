class Farmer::ProfilesController < ApplicationController
  before_action :authenticate_farmer!

  def show
    @farmer = Farmer.includes(:location).find_by(id: current_farmer.id)
    @customer = @farmer.followers.find_by(id: params[:customer_id])
    @orders = Order.joins(order_details: :item)
                   .where(items: { farmer_id: @farmer.id })
                   .distinct
                   .page(params[:page]).per(10)
  end

  def edit
   @farmer = current_farmer
  end

  def update
   @farmer = current_farmer
   if @farmer.update(farmer_params)
    sign_in(@farmer, bypass: true)
    redirect_to farmer_profile_path, notice: '更新しました'
   else
    render :edit
   end
  end

  def confirm_destroy
   @farmer = current_farmer
  end

  def destroy
   current_farmer.destroy
   sign_out current_farmer
   redirect_to root_path, notice: "退会が完了しました。ご利用ありがとうございました。"
  end

private

  def farmer_params
   params.require(:farmer).permit(:name, :email, :password, :password_confirmation, :profile_image, :image)
  end

end