class Post < ActiveRecord::Base

	attr_accessible :content, :user_id, :target_id
	
	validates :content, presence: true, length: { maximum: 1000 }
	validates :user_id, presence: true

	belongs_to :user
	has_many :post_comments

	def getTarget
		@target = User.find(target_id)
	end

	def getUser
		@target = User.find(user_id)
	end

	def getActivity
		@activity = Activity.find(content.split(' ').last)
	end

	def getComments
		@comments = PostComment.where("post_id = ?", id).order("created_at")
	end

	default_scope order: 'posts.created_at DESC'
end
