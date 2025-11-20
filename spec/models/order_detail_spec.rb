require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  it "customer, order, item があれば有効" do
    detail = build(:order_detail)
    expect(detail).to be_valid
  end

  it "customerがなければ無効" do
    detail = build(:order_detail, customer: nil)
    expect(detail).not_to be_valid
  end
end