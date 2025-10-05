module Farmer::RegistrationsHelper

  def farmer_image_tag(farmer)
    if customer.image.attached?
      image_tag customer.image
    else
      image_tag 'default-image.jpg'
    end
  end

end