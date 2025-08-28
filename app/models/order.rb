class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, bank_transfer: 1, convenience_store: 2 }
end
enum status: {
  pending: 0,
  confirmed: 1,
  shipped: 2,
  delivered: 3,
  cancelled: 4
}
end
end
