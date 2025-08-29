class ApplicationController < ActionController::Base
  helper_method :current_user_type

  def current_user_type
    return :customer if customer_signed_in?
    return :farmer if farmer_signed_in?
    :guest
  end
end
