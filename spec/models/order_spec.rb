require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:customer) { create(:customer) }
  let(:item) { create(:item) }
  let(:order) { build(:order, customer: customer, item: item) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(order).to be_valid
    end

    it 'is invalid without an item_id' do
      order.item_id = nil
      expect(order).not_to be_valid
    end

    it 'is invalid without a postal_code' do
      order.postal_code = nil
      expect(order).not_to be_valid
    end

    it 'is invalid without an address' do
      order.address = nil
      expect(order).not_to be_valid
    end

    it 'is invalid without a shipping_name' do
      order.shipping_name = nil
      expect(order).not_to be_valid
    end

    it 'is invalid if amount is less than or equal to 0' do
      order.amount = 0
      expect(order).not_to be_valid
    end

    it 'is invalid if grand_total is less than 0' do
      order.grand_total = -1
      expect(order).not_to be_valid
    end

    it 'is invalid without a payment_method' do
      order.payment_method = nil
      expect(order).not_to be_valid
    end

    it 'is invalid if shipping_cost is less than 0' do
      order.shipping_cost = -1
      expect(order).not_to be_valid
    end

    it 'is invalid without agree_policy being accepted' do
      order.agree_policy = '0'
      expect(order).not_to be_valid
    end

    it 'is invalid without a unique payment_intent_id for credit_card payment' do
      create(:order, payment_intent_id: 'unique_id', payment_method: :credit_card)
      order.payment_intent_id = 'unique_id'
      order.payment_method = :credit_card
      expect(order).not_to be_valid
    end
  end

  describe 'methods' do
    describe '#credit_card_payment?' do
      it 'returns true if payment_method is credit_card' do
        order.payment_method = 'credit_card'
        expect(order.credit_card_payment?).to be true
      end

      it 'returns false if payment_method is not credit_card' do
        order.payment_method = 'bank_transfer'
        expect(order.credit_card_payment?).to be false
      end
    end

    describe '.payment_methods_i18n' do
      it 'returns a hash of translated payment methods' do
        allow(I18n).to receive(:t).and_return('Credit Card', 'Bank Transfer', 'Convenience Store')
        expect(Order.payment_methods_i18n).to eq({
          'credit_card' => 'Credit Card',
          'bank_transfer' => 'Bank Transfer',
          'convenience_store' => 'Convenience Store'
        })
      end
    end
  end
end