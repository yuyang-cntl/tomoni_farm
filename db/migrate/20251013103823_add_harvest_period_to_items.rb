class AddHarvestPeriodToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :harvest_start, :date
    add_column :items, :harvest_end, :date
  end
end
