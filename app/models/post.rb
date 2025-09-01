class Post < ApplicationRecord
  has_many_attached :images
  belongs_to :farmer
  belongs_to :diary
end
