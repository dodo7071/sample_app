class Participation < ActiveRecord::Base
	attr_accessible :activity_id, :user_id

	belongs_to :activity
	belongs_to :user

end
