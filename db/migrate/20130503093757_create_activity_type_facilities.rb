class CreateActivityTypeFacilities < ActiveRecord::Migration
  def change
    create_table :activity_type_facilities do |t|
      t.integer :activity_type_id
      t.integer :facility_id

      t.timestamps
    end
  end
end
