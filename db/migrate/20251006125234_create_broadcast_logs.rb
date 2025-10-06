class CreateBroadcastLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :broadcast_logs do |t|
      t.references :farmer, null: false, foreign_key: true
      t.references :email_template, foreign_key: true
      t.string :subject, null: false
      t.text :body, null: false
      t.text :recipient_ids
      t.datetime :sent_at, null: false

      t.timestamps
    end
  end
end
