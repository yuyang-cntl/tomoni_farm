class AddLatitudeAndLongitudeToFarmers < ActiveRecord::Migration[6.1]
  def change
    add_column :farmers, :latitude, :float, null: false, default: 0
    add_column :farmers, :longitude, :float, null: false, default: 0
  end
end
