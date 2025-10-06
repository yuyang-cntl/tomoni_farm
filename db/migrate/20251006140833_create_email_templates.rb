class CreateEmailTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :email_templates do |t|
      t.string :title
      t.string :subject
      t.text :body
      t.references :farmer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
