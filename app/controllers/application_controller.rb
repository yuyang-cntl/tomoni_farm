class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect_guest_to_root, unless: :devise_controller?
  
  helper_method :current_user_type

  def current_user_type
    return :customer if customer_signed_in?
    return :farmer if farmer_signed_in?
    :guest
  end

  private

   def redirect_guest_to_root
    redirect_to root_path if current_user_type == :guest
   end

  protected

   def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
     devise_parameter_sanitizer.permit(:account_update, keys: [:name])
   end
end
