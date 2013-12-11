class Post < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 3 }
  validates :body, presence: true
  belongs_to :users
  has_many :comments  
end
