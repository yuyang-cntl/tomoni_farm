class Post < ApplicationRecord
  has_many_attached :images
  has_many_attached :videos
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :farmer
  belongs_to :diary
  validate :acceptable_video

  def acceptable_video
    return if videos.blank?
    videos.each do |video|
      unless video.byte_size <= 50.megabytes
        errors.add(:videos, "は50MB以下にしてください")
      end
      acceptable_types = ["video/mp4", "video/webm", "video/quicktime"]
      unless acceptable_types.include?(video.content_type)
        errors.add(:videos, "はMP4/WebM/MOV形式のみ対応しています")
      end
    end
  end
  
  def liked_by?(customer)
    return false if customer.nil?
    likes.exists?(customer_id: customer.id)
  end

  scope :within_period, ->(start_date, end_date){
    where(created_at: start_date.beginning_of_day..end_date.end_of_day)
  }

end
