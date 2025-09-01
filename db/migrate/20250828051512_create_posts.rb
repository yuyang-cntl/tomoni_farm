class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :farmer, null: false, foreign_key: true
      t.references :comment, foreign_key: true
      t.references :diary, null: false, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
