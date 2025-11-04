class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  validates :body, presence: true, length: { maximum: 500, too_long: "本文は500文字以内で入力してください"}
end
