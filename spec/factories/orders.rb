FactoryBot.define do
  factory :order do
    customer
    item
    postal_code { "123-4567" }
    address { "東京都新宿区" }
    shipping_name { "田中 太郎" }
    amount { 1 }
    grand_total { 1000 }
    payment_method { :bank_transfer }
    shipping_cost { 500 }
    agree_policy { '1' }
    payment_intent_id { "pi_#{SecureRandom.hex(8)}" }
  end
end
