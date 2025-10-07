class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :comments, dependent: :destroy
         has_many :addresses, dependent: :destroy
         belongs_to :farmer, optional: true
         has_many :follows, dependent: :destroy
         has_many :followed_farmers, through: :follows, source: :farmer
         has_many :order_details, dependent: :destroy
         has_many :orders, dependent: :destroy
         has_one_attached :profile_image

         scope :active, -> { where(is_active: true) }

  def get_profile_image(width, height)
    if profile_image.attached? && profile_image.variable?
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

  def deactivate!
    update!(is_active: false)
  end
  def reactivate!
    update!(is_active: true)
  end
  def active_for_authentication?
    super && is_active?
  end
  
  def inactive_message
    is_active? ? super : :inactive_account
  end
    
  
end
