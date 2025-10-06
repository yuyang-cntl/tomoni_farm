class OrderDetail < ApplicationRecord
  belongs_to :customer
  belongs_to :order
  belongs_to :item
end
