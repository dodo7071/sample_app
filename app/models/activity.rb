class Activity < ActiveRecord::Base

	attr_accessible :user_id, :title, :activity_type_id, :beg_date, :end_date, :beg_time, :end_time, :note, :location_id


	belongs_to :user
	belongs_to :location
	belongs_to :activity_type

	has_many :participations, dependent: :destroy
	has_many :activity_comments, dependent: :destroy
	has_many :activity_facilities, dependent: :destroy


	validates :user_id, presence: true 
	validates :title, presence: true
	validates :beg_date, presence: true
	validates :end_date, presence: true
	validates :note, presence: true, length: { maximum: 1000 }

	def getLocation
		@loc = Location.find(location_id).name
	end

	def getRegion
		@loc = Location.find(location_id).region_id
		@region = Region.find(@loc).name
	end

	def getType
		@type = ActivityType.find(activity_type_id).name
	end

	def getAuthor(author)
		@auth = User.find(author)
	end

	def participantCount(user,activity)
		@participation = Participation.where("user_id = ? AND activity_id = ?", user, activity).count
	end

	def getCommentsCount
		@count = ActivityComment.where("activity_id = ?", id).count
	end

	def getFacilitiesCount
		@count = ActivityFacility.where("activity_id = ?", id).count
	end

	def getFacilities
		@facility = Facility.find(1)
	end

	def getParticipantCount
		@count = Participation.where("activity_id = ?",id).count
	end

	def allActivities
		@act = Activity.find(:all)
	end


end
