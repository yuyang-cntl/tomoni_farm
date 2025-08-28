class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :post_id, null: false, foreign_key: true
      t.references :customer_id, null: false, foreign_key: true
      t.text :body, null: false
      t.timestamps
    end
  end
end
