class AddConctactToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contact, :string
  end
end
