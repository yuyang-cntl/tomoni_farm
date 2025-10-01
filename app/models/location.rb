class Location < ApplicationRecord
  belongs_to :farmer

  geocoded_by :full_address
  after_validation :geocode, if: :address_changed?

  def full_address
    [postal_code, prefecture, city, street].compact.join(' ')
  end
  def address_changed?
    prefecture_changed? || city_changed? || street_changed?
  end
  
end
