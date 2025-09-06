class Post < ApplicationRecord
  has_many_attached :images
<<<<<<< HEAD
=======
  has_many :likes, dependent: :destroy
>>>>>>> 5f72503 (likes_controller)
  belongs_to :farmer
  belongs_to :diary
end
