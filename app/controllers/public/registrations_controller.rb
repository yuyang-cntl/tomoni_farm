# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  private

  def sign_up_params
   params.require(:customer).permit(:name, :email, :password, :password_confirmation, :image)
  end

  def farmer_image_tag(customer)
   if customer.image.attached?
     image_tag customer.image
   else
     image_tag 'default-image.jpg'
   end
  end

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
    public_root_path
  end
  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image])
   end

end
