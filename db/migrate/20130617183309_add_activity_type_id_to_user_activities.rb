class AddActivityTypeIdToUserActivities < ActiveRecord::Migration
  def change
    add_column :user_activities, :activity_type_id, :integer
  end
end
