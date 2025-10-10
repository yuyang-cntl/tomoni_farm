class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :recipient, null: false, foreign_key: true
      t.references :actor, null: false, foreign_key: true
      t.references :notifiable, polymorphic: true, null: false
      t.boolean :read, default: false, null: false

      t.timestamps
    end
  end
end
