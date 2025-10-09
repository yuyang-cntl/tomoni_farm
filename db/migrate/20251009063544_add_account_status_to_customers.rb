class AddAccountStatusToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :account_status, :integer, default: 0, null: false
  end
end
