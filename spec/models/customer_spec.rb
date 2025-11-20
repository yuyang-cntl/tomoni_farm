require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { create(:customer, is_active: true, account_status: :active) }

  describe "#deactivate!" do
    it "アカウントを無効化する" do
      customer.deactivate!
      expect(customer.reload).to have_attributes(is_active: false, account_status: "inactive")
    end
  end

  describe "#active_for_authentication?" do
    it "is_activeがtrueならtrueを返す" do
      expect(customer.active_for_authentication?).to be true
    end

    it "is_activeがfalseならfalseを返す" do
      customer.update!(is_active: false)
      expect(customer.active_for_authentication?).to be false
    end
  end

  describe "#following?" do
    let(:farmer) { create(:farmer) }

    it "フォローしていればtrueを返す" do
      customer.followed_farmers << farmer
      expect(customer.following?(farmer)).to be true
    end

    it "フォローしていなければfalseを返す" do
      expect(customer.following?(farmer)).to be false
    end
  end
end