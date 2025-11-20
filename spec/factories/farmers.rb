FactoryBot.define do
  factory :farmer do
    sequence(:email) { |n| "farmer#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    name { "田中農園" }
  end
end