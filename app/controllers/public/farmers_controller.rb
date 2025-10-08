class Public::FarmersController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @farmers = current_customer.followed_farmers.includes(profile_image_attachment: :blob).where(is_active: true)
  end

end
