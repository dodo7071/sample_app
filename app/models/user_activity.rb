class UserActivity < ActiveRecord::Base
  attr_accessible :activity_type_id, :user_id

	belongs_to :user
	belongs_to :activity_type

	def getName
		@name = ActivityType.where("id = ?", :activity_type_id).name
	end

end
