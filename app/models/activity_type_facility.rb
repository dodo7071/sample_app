class ActivityTypeFacility < ActiveRecord::Base
	attr_accessible :activity_type_id, :facility_id

	belongs_to :activity_type
	belongs_to :facility

end
