class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :recipient, polymorphic: true, null: false
      t.references :actor, polymorphic: true, null: false
      t.references :notifiable, polymorphic: true, null: false
      t.boolean :read, default: false, null: false
      t.string :notification_key, null: false

      t.timestamps
    end
  end
end
