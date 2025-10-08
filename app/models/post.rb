class Post < ApplicationRecord
  has_many_attached :images
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :farmer
  belongs_to :diary
  
  def liked_by?(customer)
    return false if customer.nil?
    likes.exists?(customer_id: customer.id)
  end

end
