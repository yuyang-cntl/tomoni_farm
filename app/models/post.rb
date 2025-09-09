class Post < ApplicationRecord
  has_many_attached :images
  has_many :likes, dependent: :destroy
  belongs_to :farmer
  belongs_to :diary
end
