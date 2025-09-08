class Item < ApplicationRecord
  has_many_attached :images
  belongs_to :farmer
  validates :name, :introduction, :price, presence: true
end
