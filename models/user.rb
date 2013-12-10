require "digest/md5"
class User < ActiveRecord::Base
  validates :username, presence: true, length: { minimum: 3 }
  validates :email, presence: true#, format: {with /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i}
  validates :password, presence: true, length: { minimum: 6 }
  has_many :posts
  has_many :comments

  def save
    self.password = Digest::MD5.hexdigest(self.password)
    super  
  end
end
