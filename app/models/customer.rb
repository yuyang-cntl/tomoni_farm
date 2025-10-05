class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :comments, dependent: :destroy
         has_one_attached :image
         has_many :addresses, dependent: :destroy
         belongs_to :farmer, optional: true
         has_many :follows, dependent: :destroy
         has_many :followed_farmers, through: :follows, source: :farmer
         has_many :orders, dependent: :destroy
         has_many :order_details, dependent: :destroy
         has_one_attached :profile_image

  def get_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_fill: [width, height]).processed
    else
      ActionController::Base.helpers.asset_path('no_image.jpg')
    end
  end
           
  def farmer_items
    farmer&.items
  end

  def name
    "#{last_name} #{first_name}"
  end  

  def following?(farmer)
    followed_farmers.include?(farmer)
  end  
  
end
