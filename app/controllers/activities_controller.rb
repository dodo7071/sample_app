
class ActivitiesController < ApplicationController
  before_filter :signed_in_user, only: [:index, :create, :destroy, :edit, :update, :new, :my, :addFacility, :cancel]
  before_filter :correct_user,   only: [:destroy, :edit, :update]

	def new
		@activity = Activity.new
	end
  
	def show
		@activity= Activity.find(params[:id])
		@participants = User.joins(:participations).where("activity_id = ?", @activity.id).paginate(page: params[:page])
    	@activity_comments = ActivityComment.where("activity_id = ?", @activity.id).paginate(page: params[:page])
		@facilities = Facility.joins(:activity_facilities).where("activity_id = ?", @activity.id)
		@activity_comment = @activity_comments.build
		@similiar = Activity.where("location_id = ? AND activity_type_id = ?", @activity.location_id, @activity.activity_type_id)
		@similiar = @similiar.shuffle[0,20]

	end

	def my
		@activities = Activity.where("user_id = ?", current_user.id).order("beg_date asc").paginate(page: params[:page])
		@foll_act = Activity.joins(:user).joins("inner join followings on followings.followed_id = user_id").where("follower_id = ? AND activities.user_id != ?", current_user.id, current_user.id)
		@foll_act = @foll_act.shuffle[0,50]
	end

	def participations
		@activities = Activity.joins(:participations).where("participations.user_id = ? AND beg_date >= ?", current_user.id, Date.today.to_date).order("beg_date asc").paginate(page: params[:page])
		@recommended = Activity.where("location_id = ?", current_user.location_id)
		@recommended = @recommended.shuffle[0,50]
	end

	def addFacility
	end	

	def join
		if signed_in?
			@activity = Activity.find(params[:id])
			@participation = Participation.new
			@participation.activity_id = params[:id]
			@participation.user_id = current_user.id
			@participation.save!
			redirect_to :action => "show", :id => @activity.id
			flash[:success] = "Successfuly joined!"
		else
			flash[:alert] = "You have to sign in to join this activity!"
			redirect_to signin_path
		end
	end

	def cancel
		@activity = Activity.find(params[:id])
		@participation = Participation.where("user_id = ? AND activity_id = ?", current_user, @activity.id)
		@participation.destroy(@participation.first.id)
		redirect_to :back
			flash[:success] = "Successfuly canceled!"
	end

	def getParticipations(activity)
		@participations = Participation.where("activity_id = ?", activity.id)
	end

	def edit
		@activity= Activity.find(params[:id])
	end

	def update

		@activity= Activity.find(params[:id])

		if @activity.update_attributes(params[:activity])
			flash[:success] = "Activity updated"   
			redirect_to @activity
		else
			render 'edit'
		end
	end


	def find_activities
		@activities = Activity.where("activity_type_id = ? AND location_id = ? AND beg_date >= ?", params[:activity_type_id], params[:location_id], Date.today.to_date).order("beg_time").paginate(page: params[:page])

		@location = params[:location_id]
		@type = params[:activity_type_id]
	end

	def index
		@activities = Activity.paginate(page: params[:page])
	end

	def create

		@activity = current_user.activities.build(params[:activity])

		@post = Post.new
		@post.user_id = @activity.user_id
		@post.target_id = @activity.user_id 

		if @activity.save
			@post.content = "# " + @activity.id.to_s
			@post.save!
			flash[:success] = "Activity created!"
			redirect_to :action => "show", :id => @activity
		else
			render 'static_pages/home'
		end
	end

	def destroy

		@participation = Participation.where("activity_id = ?", @activity.id)
		@participation.each do |i|
			i.destroy
		end

		@activity.destroy
		redirect_to root_url
	end

	def removeFacility(id)
		@fac = Facility.find(id)
		@fac.destroy
	end

	private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
		@activity = current_user.activities.find_by_id(params[:id])
		redirect_to root_url if @activity.nil?
    end

end


