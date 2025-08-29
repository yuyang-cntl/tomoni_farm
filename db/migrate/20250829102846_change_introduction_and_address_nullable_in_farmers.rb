class ChangeIntroductionAndAddressNullableInFarmers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :farmers, :introduction, true
    change_column_null :farmers, :address, true
  end
end
