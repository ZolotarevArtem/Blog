require "digest/md5"
class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  validates :username, presence: true, length: { minimum: 3 } #uniqueness
  validates :email, presence: true#, format: {with /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i} 
  validates :password, presence: true, length: { minimum: 6 }

  def save
    self.password = Digest::MD5.hexdigest(self.password)
    super  
  end
end
