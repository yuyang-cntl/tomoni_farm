module Public::RegistrationsHelper

  def customer_image_tag(customer)
    if customer.image.attached?
      image_tag customer.image
    else
      image_tag 'default-image.jpg'
    end
  end

end