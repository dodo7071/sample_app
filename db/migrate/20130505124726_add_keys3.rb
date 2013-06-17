class AddKeys3 < ActiveRecord::Migration
  def change
    add_foreign_key "activity_facilities", "activities", :name => "activity_facilities_activity_id_fk"
    add_foreign_key "activity_facilities", "facilities", :name => "activity_facilities_facility_id_fk"
  end
end
