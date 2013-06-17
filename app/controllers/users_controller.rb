class UsersController < ApplicationController

	before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :addfavourite, :show, :info, :follow, :unfollow, :followers, :following]
	before_filter :correct_user,   only: [:edit, :update, :addfavourite]
	before_filter :admin_user,     only: :destroy

	def show
		@user = User.find(params[:id])
		@favourites = UserActivity.where("user_id = ?", @user.id)
		@posts = Post.where("target_id = ?", @user.id).limit(30)
		@activities = Activity.joins(:participations).where("participations.user_id = ?", @user.id).order("beg_date desc")
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
		@following = Following.new
		@following.follower_id = @user.id
		@following.followed_id = @user.id
		@following.save!
			flash[:success] = "Welcome to the Activity Finder. Feel free to use it.\n"
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
	end

	def addfavourite
	end

	def update
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

	def index

		@users = User.joins("inner join participations on participations.user_id = users.id").joins("inner join activities on participations.activity_id = activities.id").where("users.id != ?", current_user.id).limit(100)

		@users = @users.shuffle[0,20]
	end

	def info
		@user = User.find(params[:id])
	end

	def follow
		@user = User.find(params[:id])
		@following = Following.new
		@following.follower_id = current_user.id
		@following.followed_id = @user.id
		@following.save!

		redirect_to @user
	end

	def unfollow
		@user = User.find(params[:id])
		@following = Following.where("follower_id = ? and followed_id = ?", current_user.id, @user.id).destroy_all

		redirect_to @user
	end

	def followers
		@user = User.find(params[:id])
		@followers = User.joins("inner join followings on followings.follower_id = users.id").where("followed_id = ?", @user.id)
	end

	def following
		@user = User.find(params[:id])
		@followings = User.joins("inner join followings on followings.followed_id = users.id").where("follower_id = ?", @user.id)
	end

	def find_users
		@users = User.where("location_id = ? AND name ilike ?", params[:location_id], '%' + params[:name] + '%').joins(:user_activities).where("activity_type_id = ?", params[:activity_type_id])
	end

	def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
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

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
