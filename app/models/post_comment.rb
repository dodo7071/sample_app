class PostComment < ActiveRecord::Base
	attr_accessible :content, :post_id, :user_id

	belongs_to :post
	belongs_to :user

	def getUser
		@user = User.find(user_id)
	end

end
