class User < ActiveRecord::Base

  has_many :posts
  has_many :comments

  has_secure_password
  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_]+\Z/ }
  validates :password, presence: true

end