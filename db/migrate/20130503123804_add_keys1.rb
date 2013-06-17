class AddKeys1 < ActiveRecord::Migration
  def change
    add_foreign_key "activities", "activity_types", :name => "activities_activity_type_id_fk"
    add_foreign_key "activities", "locations", :name => "activities_location_id_fk"
    add_foreign_key "activities", "users", :name => "activities_user_id_fk"
    add_foreign_key "activity_type_facilities", "activity_types", :name => "activity_type_facilities_activity_type_id_fk"
    add_foreign_key "activity_type_facilities", "facilities", :name => "activity_type_facilities_facility_id_fk"
    add_foreign_key "evaluations", "facilities", :name => "evaluations_facility_id_fk"
    add_foreign_key "evaluations", "users", :name => "evaluations_user_id_fk"
    add_foreign_key "facilities", "locations", :name => "facilities_location_id_fk"
    add_foreign_key "participations", "activities", :name => "participations_activity_id_fk"
    add_foreign_key "participations", "users", :name => "participations_user_id_fk"
  end
end
