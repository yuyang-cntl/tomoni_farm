class Item < ApplicationRecord
  has_many_attached :images
  has_many_attached :orders
  has_many :order_details
  belongs_to :farmer
  validates :name, :introduction, :price, :status, presence: true

  enum status: { on_sale: 0, off_sale: 1}

  def self.statuses_i18n
    statuses.keys.index_with do |key|
     I18n.t("activerecord.attributes.item.statuses.#{key}")
    end
  end
  def status_label
    return "未設定" if status.nil?
    I18n.t("activerecord.attributes.item.statuses.#{status}")
  end  
  
  after_initialize do
    self.status ||= :on_sale
  end
  
end
