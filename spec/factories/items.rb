FactoryBot.define do
  factory :item do
    association :farmer
    name { "トマト" }
    introduction { "甘くて美味しいトマトです" }
    price { 300 }
    status { :on_sale }
    harvest_start { Date.today }
    harvest_end { Date.today + 7 }

    after(:build) do |item|
      item.images.attach(
        io: File.open(Rails.root.join("spec/fixtures/files/sample.jpg")),
        filename: "sample.jpg",
        content_type: "image/jpeg"
      )
    end
  end
end