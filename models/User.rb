require "digest/md5"
class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  
  before_save :hash_password  
  
  validates :username, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: true, format: { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }

  def auth(pass)
    self.password == hash(pass)
  end

  private

  def hash(pass)
    Digest::MD5.hexdigest(pass)
  end

  def hash_password
    self.password = hash(self.password)
  end
end
