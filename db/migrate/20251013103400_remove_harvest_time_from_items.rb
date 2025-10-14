class RemoveHarvestTimeFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :harvest_time, :date
  end
end
