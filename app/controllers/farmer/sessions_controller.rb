# frozen_string_literal: true

class Farmer::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
   def new
     super
   end

  # POST /resource/sign_in
   def create
    sign_out(:customer) if customer_signed_in?
     super
   end

  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインせいこう"
    farmer_root_path
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました"
    new_farmer_session_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  # end
end
