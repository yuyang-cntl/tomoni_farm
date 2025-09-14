class Farmer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 30}

  has_one_attached :image
  has_many :items, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :customers
  has_many :reverse_follows, class_name: "Follow", dependent: :destroy
  has_many :followers, through: :reverse_follows, source: :customer
  has_one_attached :profile_image

  def get_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_fill: [width, height]).processed
    else
      ActionController::Base.helpers.asset_path('no_image.jpg')
    end
  end
  
end
