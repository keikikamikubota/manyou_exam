class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :password_digest, :string
    add_index :users, :email, unique: true
  end
end
