require 'rails_helper'

RSpec.describe Follow, type: :model do
  it "customerとfarmerがあれば有効" do
    follow = build(:follow)
    expect(follow).to be_valid
  end

  it "customerがなければ無効" do
    follow = build(:follow, customer: nil)
    expect(follow).not_to be_valid
  end
end