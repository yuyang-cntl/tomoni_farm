class Public::FarmersController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    if current_customer.farmer.present?
      @farmers = current_customer.farmers.includes(images_attachments: :blob)
      else
        @farmers = []
      end
    @farmers = Item.includes(images_attachments: :blob).where(is_active: true)
  end

end
