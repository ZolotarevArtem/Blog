class Comment < ActiveRecord::Base
  validates :body, presence: true
  belongs_to :posts
  belongs_to :users
end
