class Farmer::PasswordChangesController < ApplicationController
  before_action :authenticate_farmer!
  
  def edit
   @farmer = current_farmer
  end
   
  def update
   @farmer = current_farmer
   if @farmer.update(farmer_params)
    sign_in(@farmer, bypass: true)
    redirect_to edit_farmer_profile_path, notice: '更新しました'
   else
    render :edit
   end
  end
    
  private
  
  def farmer_params
   params.require(:farmer).permit(:name, :email, :password, :password_confirmation, :image)
  end

end
