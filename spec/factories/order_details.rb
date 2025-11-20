FactoryBot.define do
  factory :order_detail do
    association :customer
    association :order
    association :item
  end
end