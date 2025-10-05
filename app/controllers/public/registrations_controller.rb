# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # def sign_up_params
  #  params.require(:customer).permit(:name, :email, :password, :password_confirmation, :image)
  # end

   protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [
     :last_name, :first_name,
     :last_name_kana, :first_name_kana,
     :postal_code, :address, :telephone_number, :image
 ])
   end

   def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
    :last_name, :first_name,
    :last_name_kana, :first_name_kana,
    :postal_code, :address, :telephone_number, :image
 ])
   end
  
   def after_sign_up_path_for(resource)
    public_customers_root_path
   end
  # If you have extra params to permit, append them to the sanitizer.

end
