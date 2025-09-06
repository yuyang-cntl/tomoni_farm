# frozen_string_literal: true

class Farmer::RegistrationsController < Devise::RegistrationsController
   before_action :configure_sign_up_params, only: [:create]
   before_action :configure_account_update_params, only: [:update]

  
   private

   def sign_up_params
    params.require(:farmer).permit(:name, :email, :password, :password_confirmation, :image)
   end

   def farmer_image_tag(farmer)
    if farmer.image.attached?
      image_tag farmer.image
    else
      image_tag 'default-image.jpg'
    end
   end
  
   protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image])
   end

  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image])
   end

  # The path used after sign up.
   def after_sign_up_path_for(resource)
     farmer_root_path
   end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
