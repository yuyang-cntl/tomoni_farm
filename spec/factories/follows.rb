FactoryBot.define do
  factory :follow do
    association :customer
    association :farmer
  end
end