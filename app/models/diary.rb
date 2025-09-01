class Diary < ApplicationRecord
  has_many_attached :images
  belongs_to :farmer
  validates :body, presence: true, length: { maximum: 500, too_long: "本文は500文字以内で入力してください"}
end
