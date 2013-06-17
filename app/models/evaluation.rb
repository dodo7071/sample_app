class Evaluation < ActiveRecord::Base
	attr_accessible :activity_id, :facility_id, :note, :user_id, :value

	belongs_to :facility
	belongs_to :user

	def getUser
 		@user = User.find(user_id)
	end

end
