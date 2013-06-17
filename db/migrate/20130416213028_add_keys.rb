class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "activities", "activity_types", :name => "activities_activity_type_id_fk"
    add_foreign_key "activities", "locations", :name => "activities_location_id_fk"
    add_foreign_key "activities", "users", :name => "activities_user_id_fk"
    add_foreign_key "locations", "regions", :name => "locations_region_id_fk"
    add_foreign_key "user_activities", "users", :name => "user_activities_user_id_fk"
  end
end
