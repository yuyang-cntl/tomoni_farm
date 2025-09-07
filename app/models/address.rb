class Address < ApplicationRecord
  belongs_to :customer
  validates :name, :postal_code, :address, presence: true
end
