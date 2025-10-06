module Public::RegistrationsHelper

  def customer_image_tag(customer)
    if customer.profile_image.attached?
      image_tag customer.profile_image
    else
      image_tag 'default-image.jpg'
    end
  end

end