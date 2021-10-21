class AddAttributesToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string, index: true, unique: true
    add_column :users, :bio, :string
    add_column :users, :text, :string, index: true
  end
end
