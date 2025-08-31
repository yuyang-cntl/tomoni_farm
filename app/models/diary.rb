class Diary < ApplicationRecord
  has_many_attached :images
  belongs_to :farmer
end
