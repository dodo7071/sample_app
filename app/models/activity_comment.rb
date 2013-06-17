class ActivityComment < ActiveRecord::Base
	attr_accessible :activity_id, :text, :user_id

	validates :text, length: { maximum: 250 }

	belongs_to :user
	belongs_to :activity

	def getAuthor(author)
		@auth = User.find(author)
	end
	

	default_scope order: 'activity_comments.created_at DESC'

end
