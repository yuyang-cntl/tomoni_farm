class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :item, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.integer :shipping_cost, null: false
      t.integer :payment_method, null: false, default: 0
      t.integer :grand_total, null: false
      t.integer :status, null: false, default: 0
      t.string :postal_code, null: false
      t.string :destination, null: false
      t.string :shipping_name, null: false
      t.timestamps
    end
  end
end
