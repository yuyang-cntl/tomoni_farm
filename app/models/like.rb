class Like < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  has_one_attached :profile_image

  def get_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_fill: [width, height]).processed
    else
      ActionController::Base.helpers.asset_path('default-image.jpg')
    end
  end

  validates :customer_id, uniqueness: {scope: :post_id}
end
