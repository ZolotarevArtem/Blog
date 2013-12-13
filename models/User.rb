#require "./helpers.rb"
class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  
  validates :username, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :password, length: { minimum: 6 }, confirmation: true
  validates :email, presence: true, uniqueness: true, format: { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  
end
