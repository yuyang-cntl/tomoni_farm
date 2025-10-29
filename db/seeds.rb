# Farmerのログイン用アカウント
farmer = Farmer.find_or_initialize_by(email: 'farmer@example.com')
farmer.password = 'password'
farmer.name = '山田'
farmer.introduction = '和歌山県の農家です'
farmer.save!

location = Location.create!(
  farmer: farmer,
  postal_code: "640-1364",
  prefecture: "和歌山県",
  city: "海草郡紀美野町",
  street: "西野971-1",
  latitude: 34.226,
  longitude: 135.370
)
location.save!


farmer.profile_image.attach(
  io: File.open(Rails.root.join('db','seed_images','no_image.jpg')),
  filename: 'no_image.jpg',
  content_type: 'image/jpg'
)
farmer.save!

# Customerのログイン用アカウント
customer = Customer.find_or_initialize_by(email: 'customer@example.com') 
customer.password = 'password'
customer.last_name = '山田'
customer.first_name = '太郎'
customer.last_name_kana = 'ヤマダ'
customer.first_name_kana = 'タロウ'
customer.save!

customer.profile_image.attach(
  io: File.open(Rails.root.join('db','seed_images','no_image.jpg')),
  filename: 'no_image.jpg',
  content_type: 'image/jpg'
)
customer.save!