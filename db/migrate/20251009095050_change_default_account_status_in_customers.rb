class ChangeDefaultAccountStatusInCustomers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :customers, :account_status, from: 0, to: 1
  end
end
