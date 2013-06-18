class StaticPagesController < ApplicationController

	def home
		if(signed_in?)
			@posts = Post.joins("inner join followings on followings.followed_id = posts.target_id").where("follower_id = ? or target_id = ?", current_user.id, current_user.id).uniq.order("created_at asc")
			@activities = Activity.joins(:participations).where("participations.user_id = ? AND beg_date > ?", current_user.id, Date.today.to_date).order("beg_date asc").limit(5)
			@my_activities = Activity.where("user_id = ? AND beg_date > ?", current_user.id, Date.today.to_date).order("beg_date asc")
		end
	end

	def about
	end

	def sign_in
	end

	def wall
		if signed_in?
			@activity = Activity.where("user_id = ?", current_user.id).paginate(page: params[:page])
		end
	end

	def create_activity
		if signed_in?
			@activity  = current_user.activities.build
			@feed_items = current_user.feed.paginate(page: params[:page])
		end
	end

end
