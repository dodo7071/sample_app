class PostCommentsController < ApplicationController
	before_filter :signed_in_user

	def new
		@comment = PostComment.new
	end

	def create
		@comment = current_user.post_comments.build(params[:post_comment])
		if @comment.save!
			flash[:success] = "Comment added!"
			redirect_to(:back)
		else
			render 'static_pages/home'
		end
	end

	def destroy
	end

end
