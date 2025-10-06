class BroadcastLog < ApplicationRecord
  belongs_to :farmer
  belongs_to :email_template, optional: true

  serialize :recipient_ids, Array

  validates :subject, :body, :sent_at, presence: true
end
