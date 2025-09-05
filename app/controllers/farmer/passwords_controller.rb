class Farmer::PasswordsController < Devise::PasswordsController
  before_action :authenticate_farmer!

  def set_devise_mapping
   request.env["devise.mapping"] = Devise.mappings[:farmer]
  end

  def edit
   @farmer = current_farmer
  end
 
  def update
   @farmer = current_farmer
   if @farmer.update(farmer_params)
    bypass_sign_in(@farmer)
    redirect_to edit_farmer_profile_path, notice: '更新しました'
   else
    render :edit
   end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
  
  private

  def farmer_params
   params.require(:farmer).permit(:name, :email, :password, :password_confirmation, :image)
  end

end
