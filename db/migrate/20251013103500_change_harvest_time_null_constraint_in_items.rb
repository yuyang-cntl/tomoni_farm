class ChangeHarvestTimeNullConstraintInItems < ActiveRecord::Migration[6.1]
  def change
    change_column_null :items, :harvest_time, true
  end
end
