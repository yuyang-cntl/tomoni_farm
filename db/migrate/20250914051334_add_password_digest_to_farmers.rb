class AddPasswordDigestToFarmers < ActiveRecord::Migration[6.1]
  def change
    add_column :farmers, :password_digest, :string
  end
end
