class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :entry
  validates :body, presence: true
end
