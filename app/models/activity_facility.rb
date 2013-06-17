class ActivityFacility < ActiveRecord::Base
	attr_accessible :activity_id, :facility_id

	belongs_to :activity
	belongs_to :facility


	def getActivity
		@activity = Activity.find(activity_id)
	end	

	def getFacility
		@facility = Facility.find(facility_id)
	end

end
