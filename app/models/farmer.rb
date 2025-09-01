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
end
