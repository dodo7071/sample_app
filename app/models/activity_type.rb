class ActivityType < ActiveRecord::Base
	attr_accessible :all

	has_many :activities
	has_many :user_activities
	has_many :activity_type_evaluations

end
