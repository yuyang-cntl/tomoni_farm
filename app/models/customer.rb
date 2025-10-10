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
         has_many :notifications, as: :recipient, dependent: :destroy
         has_many :sent_notifications, as: :actor, class_name: "Notification"

         scope :active, -> { where(is_active: true) }

         enum account_status: { inactive: 0, active: 1 }

  def self.account_statuses_i18n
    account_status.keys.each_with_object({}) do |key, hash|
    hash[key] = I18n.t("activerecord.attributes.account_status.#{key}")
   end
  end

  def account_status_i18n
    I18n.t("activerecord.attributes.account_status.#{account_status}")
  end

  def account_status_badge_class
    case account_status
    when "active"
      "badge badge-success"
    when "inactive"
      "badge badge-danger"
    when nil
      "badge badge-light"
    end
  end

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
    update!(is_active: false, account_status: :inactive)
  end
  def reactivate!
    update!(is_active: true, account_status: :active)
  end
  def active_for_authentication?
    super && is_active?
  end
  
  def inactive_message
    is_active? ? super : :inactive_account
  end
    
  
end
