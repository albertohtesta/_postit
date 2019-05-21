class User < ActiveRecord::Base
	has_many :posts
	has_many :comments
	has_many :votes

	has_secure_password 
	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, on: :create, length: {minimum: 5}  # solo valida al crear
	
end