class PostsController < ApplicationController
	before_filter :signed_in_user

	def create
		@post = current_user.posts.build(params[:post])
		if @post.save
			flash[:success] = "Post created!"
			redirect_to proc { user_url(@post.target_id) }
		else
			render 'static_pages/home'
		end
	end

	def destroy
	end

end
