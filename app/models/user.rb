class User < ActiveRecord::Base
	include Sluggable
	has_many :posts
	has_many :comments
	has_many :votes

	has_secure_password 
	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, on: :create, length: {minimum: 5}  # solo valida al crear
	
	sluggable_column :username

	def admin?
		self.role == 'admin'
	end

	def moderator?
		self.role == 'moderator'
	end

end