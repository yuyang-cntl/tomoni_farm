class EmailTemplate < ApplicationRecord
  belongs_to :farmer
 
  validates :title, :subject, :body, presence: true

end
