class AddTelephoneToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :telephone, :string
  end
end
