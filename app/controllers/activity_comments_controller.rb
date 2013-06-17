class ActivityCommentsController < ApplicationController

	before_filter :signed_in_user, only: [:create, :destroy]

	def new
		@activity_comment = ActivityComment.new
	end

	def create
		@activity_comment = ActivityComment.new(params[:activity_comment])
		@activity_comment.user_id = current_user.id 
		if @activity_comment.save
			flash[:success] = "Comment added!"
			redirect_to proc { activity_url(@activity_comment.activity_id) }
		end
	end

	def destroy
	end

end
