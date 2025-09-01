class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.references :farmer, null: false, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
