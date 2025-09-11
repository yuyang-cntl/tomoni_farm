class Address < ApplicationRecord
  belongs_to :customer
  validates :shipping_name, :postal_code, :address, presence: true

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + shipping_name
  end

end
