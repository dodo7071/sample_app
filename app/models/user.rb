# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
	attr_accessible :id, :name, :email, :password, :password_confirmation, :birth_date, :contact, :location_id
	has_secure_password

	has_many :activities, dependent: :destroy
	has_many :user_activities, dependent: :destroy  
	has_many :evaluations
	has_many :participations, dependent: :destroy
	has_many :activity_comments, dependent: :destroy
	has_many :posts, dependent: :destroy
	has_many :post_comments, dependent: :destroy
	has_many :followings, dependent: :destroy

	has_many :reverse_followings, class_name:  "Following", dependent:   :destroy
	has_many :followers, through: :reverse_followings, source: :follower

	has_many :followed_users, through: :followings, source: :followed

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def feed
    Activity.where("user_id = ?", id)
  end

	def myActivities
		@x = UserActivity.where("user_id = ?", id)
	end

	def getActivities
		@act = Activity.where("user_id = ?", id)
	end

	def getActivityCount
		@count = Activity.where("user_id = ?", id).count
	end
	
	def getType(type)
		@type = ActivityType.find(type)
	end

	def getLocation
		@loc = Location.find(location_id).name
	end

	def age(dob)
  		now = Time.now.utc.to_date
  		now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
	end

	def getParticipatingActivities
		@participations = Participation.where("user_id = ?", id).activity_id
		@activities = Activities.find(@participations)
	end

	def getFollowedCount
		@count = Following.where("follower_id = ?", id).count
	end

	def getFollowersCount
		@count = Following.where("followed_id = ?", id).count
	end

	def followingsCount(user)
		@count = Following.where("follower_id = ? AND followed_id = ?", id, user.id).count
	end

	def getFollowings(user)
		@followings = Following.where("follower_id = ? AND followed_id = ?", id, user.id)
	end

	def following?(other_user, user)
		Following.where("followed_id = ? AND follower_id = ?", other_user.id, user.id)
	end

	def follow!(other_user)
		followings.create!(followed_id: other_user.id)
	end

	def unfollow!(other_user)
		followings.find_by_followed_id(other_user.id).destroy
	end

	private

    def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64
    end
end
