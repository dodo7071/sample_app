class CreateActivityFacilities < ActiveRecord::Migration
  def change
    create_table :activity_facilities do |t|
      t.integer :activity_id
      t.integer :facility_id

      t.timestamps
    end
  end
end
