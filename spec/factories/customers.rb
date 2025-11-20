FactoryBot.define do
  factory :customer do
    sequence(:email) { |n| "customer#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    first_name { "太郎" }
    last_name { "山田" }
    is_active { true }
    account_status { :active }

    trait :inactive do
      is_active { false }
      account_status { :inactive }
    end
  end
end