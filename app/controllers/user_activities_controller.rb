class UserActivitiesController < ApplicationController

	def new
		@userActivity = UserActivity.new
 	end

end
