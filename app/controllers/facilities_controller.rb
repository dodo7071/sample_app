class FacilitiesController < ApplicationController

	before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :set]

	def index
		@favourite = Facility.joins(:activity_facilities => :activity).where("user_id = ?", current_user.id).group("facilities.id").order("facilities asc").limit(50)
		@recommended = Facility.where("location_id = ?", current_user.location_id)
		@recommended = @recommended.shuffle[0,10]
	end

	def show
		@facility = Facility.find(params[:id])
		@evaluations = Evaluation.where("facility_id = ?", @facility.id).paginate(page: params[:page])
		@activityTypes = ActivityTypeFacility.where("facility_id = ?", @facility.id)
		@similiar = Facility.includes(:activity_type_facilities).where("location_id = ?", @facility.location_id)
    	
		@activities = Activity.joins(:activity_facilities).order("beg_date")

		@json = @facility.to_gmaps4rails

	end

	def evaluate
		if signed_in?
			@evaluation = Evaluation.new
		else
			flash[:alert] = "You have to sign in to add evaluations!"
			redirect_to signin_path
		end
	end

	def addToActivity
		if signed_in?
			@facility = Facility.find(params[:id])
		else
			flash[:alert] = "You have to sign in to add facility to your activity!"
			redirect_to signin_path
		end
	end

	def set
		@facility = Facility.find(params[:id])

		@activity_facility = ActivityFacility.new
		@activity_facility.facility_id = @facility.id
		@activity_facility.activity_id = params[:activity_id]
		@activity_facility.save!
		redirect_to :action => "show", :id => @facility.id
		flash[:success] = "Successfuly joined!"
	end

	def find_facilities
		@facility = Facility.where("location_id = ?", params[:location_id]).paginate(page: params[:page])
		@location = params[:location_id]
		@type = params[:activity_type_id]
		@favourite = Facility.all #.joins(:activity_facilities => :activity).where("user_id = ?", current_user.id).group("facilities.id").order("facilities asc").limit(30)
		@recommended = Facility.all
	end

	  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end


	  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

end
