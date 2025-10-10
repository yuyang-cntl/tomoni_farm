class Farmer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 30}

  has_one :location, dependent: :destroy
  accepts_nested_attributes_for :location

  has_many :items, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :customers
  has_many :reverse_follows, class_name: "Follow", dependent: :destroy
  has_many :followers, through: :reverse_follows, source: :customer
  has_one_attached :profile_image
  has_many :email_templates, dependent: :destroy
  has_many :broadcast_logs, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :sent_notifications, as: :actor, class_name: "Notification"

  def get_profile_image(width, height)
    if profile_image.attached? && profile_image.variable?
      profile_image.variant(resize_to_fill: [width, height]).processed
    else
      ActionController::Base.helpers.asset_path('no_image.jpg')
    end
  end
  
end
