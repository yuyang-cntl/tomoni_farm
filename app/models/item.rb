class Item < ApplicationRecord
  has_many_attached :images
  has_many :orders, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :farmer
  
  validates :name, :introduction, :price, :status, presence: true
  validates :harvest_start, presence: true
  validates :harvest_end, presence: true
  validate :harvest_period_valid

  enum status: { on_sale: 0, off_sale: 1}

  def harvest_period_valid
    if harvest_start && harvest_end && harvest_start > harvest_end
      errors.add(:harvest_end, "は収穫開始日より後の日付を指定してください")
    end
  end

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
