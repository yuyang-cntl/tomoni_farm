class ChangeHarvestTimeToDateInItem < ActiveRecord::Migration[6.1]
  def change
    change_column :items, :harvest_time, :date
  end
end
