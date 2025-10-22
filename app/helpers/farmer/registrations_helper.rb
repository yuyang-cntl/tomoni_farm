module Farmer::RegistrationsHelper

  def farmer_image_tag(farmer)
    if farmer.profile_image.attached?
      image_tag farmer.profile_image
    else
      image_tag 'https://pf-yuyang-bucket.s3.ap-northeast-1.amazonaws.com/default-image.jpg'
    end
  end

end