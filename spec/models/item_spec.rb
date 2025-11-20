require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:farmer) { create(:farmer) }

  it "収穫開始日が終了日より後なら無効" do
    item = build(:item, farmer: farmer, harvest_start: Date.today + 5, harvest_end: Date.today)
    expect(item).not_to be_valid
    expect(item.errors[:harvest_end]).to include("は収穫開始日より後の日付を指定してください")
  end

  it "価格が0以下なら無効" do
    item = build(:item, farmer: farmer, price: 0)
    expect(item).not_to be_valid
  end
end