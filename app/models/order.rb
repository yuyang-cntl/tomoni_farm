class Order < ApplicationRecord

  belongs_to :customer
  belongs_to :item
  has_many :order_details, dependent: :destroy

  validates :item_id, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :shipping_name, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :grand_total, numericality: { greater_than_or_equal_to: 0 }
  validates :payment_method, presence: true
  validates :shipping_cost, numericality: { greater_than_or_equal_to: 0 }
  attr_accessor :agree_policy
  validates :agree_policy, acceptance: { accept: '1' }
  validates :payment_intent_id, presence: true, uniqueness: true, if: -> { credit_card_payment? && new_record? }
  
  enum payment_method: { credit_card: 0, bank_transfer: 1, convenience_store: 2 }
  enum status: {
   pending: 0,
   confirmed: 1,
   shipped: 2,
   delivered: 3,
   cancelled: 4
  }

  def credit_card_payment?
   payment_method == "credit_card"
  end

  def self.payment_methods_i18n
   payment_methods.keys.each_with_object({}) do |key, hash|
   hash[key] = I18n.t("activerecord.attributes.order.payment_methods.#{key}")
  end
 end
end
