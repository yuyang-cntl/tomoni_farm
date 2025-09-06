class Farmer::ProfilesController < ApplicationController
  before_action :authenticate_farmer!

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
   params.require(:farmer).permit(:name, :email, :password, :password_confirmation, :image)
  end

end
