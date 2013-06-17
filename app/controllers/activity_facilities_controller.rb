class ActivityFacilitiesController < ApplicationController
  	def new
		@activity_facility = ActivityFacility.new
	end

	def create
		@activity_facility = ActivityFacility.new(params[:activity_facility])
		if @activity_facility.save
			flash[:success] = "Successuly joined!"
			redirect_to proc { facility_url(@activity_facility.facility_id) }
		end
	end

  def show
	@activity_facility = ActivityFacility.find(params[:id])
  end

end
