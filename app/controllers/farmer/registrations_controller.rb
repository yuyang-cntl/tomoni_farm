# frozen_string_literal: true

class Farmer::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def new
   @farmer = Farmer.new
   @farmer.build_location
  end

  private

 #  def sign_up_params
   # params.require(:farmer).permit(:name, :email, :password, :password_confirmation, :image)
 #  end

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
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image,
    location_attributes: [:prefecture, :city, :street, :postal_code]
  ])
  end

 # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image,
    location_attributes: [:prefecture, :city, :street, :postal_code]
  ])
  end
end