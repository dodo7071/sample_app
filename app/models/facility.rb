class Facility < ActiveRecord::Base
  attr_accessible :id, :adress, :email, :gps, :info, :location_id, :services, :title, :web_page, :telephone

	belongs_to :location

	has_many :evaluations, dependent: :destroy
	has_many :activity_facilities, dependent: :destroy
	has_many :activity_type_facilities, dependent: :destroy

	acts_as_gmappable
		def gmaps4rails_address
			"Rio de Janeiro, Brasil"
		end
		def gmaps4rails_infowindow
         "<h4>RIO</h4>" << "<h4>#{address}</h4>"
		end

	def getLocation
		@location = Location.find(location_id).name
	end

	def allFacilities
		@facility = Facility.all.order('title ASC').paginate(page: params[:page])
	end

	
	def getEvaluationsCount
		@count = Evaluation.where("facility_id = ?", id).count
	end

	def getEvaluation
		@evaluations = Evaluation.where("facility_id = ?", id)
		@average = @evaluations.average('value')
	end

	def getActivityTypesCount
		@count = ActivityTypeFacility.where("facility_id = ?", id).count
	end

	def getType(type)
		@type = ActivityType.find(type)
	end

	def getTypes
		@types = ActivityType.limit(3)
	end

	def longitude
		-43.2095869
	end

	def latitude
		-22.9035393
	end
end
