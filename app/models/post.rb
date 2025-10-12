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

  scope :within_period, ->(start_date, end_date){
    where(created_at: start_date.beginning_of_day..end_date.end_of_day)
  }

end
