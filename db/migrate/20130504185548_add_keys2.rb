class AddKeys2 < ActiveRecord::Migration
  def change
    add_foreign_key "activity_comments", "activities", :name => "activity_comments_activity_id_fk"
    add_foreign_key "activity_comments", "users", :name => "activity_comments_user_id_fk"
  end
end
