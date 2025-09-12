class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :comments, dependent: :destroy
         has_one_attached :image
         has_many :comments, dependent: :destroy
         has_many :addresses
         belongs_to :farmer, optional: true
         has_many :follows
         has_many :followed_farmers, through: :follows, source: :farmer, dependent: :destroy
         has_many :orders
         has_many :order_details
         
  def farmer_items
    farmer&.items
  end

  def name
    "#{last_name} #{first_name}"
  end  

  def following?(farmer)
    followed_farmers.include?(farmer)
  end  
  
end
