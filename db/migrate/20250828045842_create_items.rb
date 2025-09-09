class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :farmer, null: false, foreign_key: true
      t.string :name, null: false
      t.text :introduction, null: false
      t.string :harvest_time, null: false
      t.integer :price, null: false
      t.integer :status
      t.boolean :is_active, null: false,default: true
      t.timestamps
    end
  end
end
