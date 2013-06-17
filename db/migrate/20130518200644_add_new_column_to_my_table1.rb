class AddNewColumnToMyTable1 < ActiveRecord::Migration
  def change
	add_column :users, :location_id, :integer
  end
end
