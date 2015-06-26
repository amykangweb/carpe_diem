class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal
  has_many :cheers, dependent: :destroy
  has_many :cheering_users, through: :cheers, source: :user
  has_many :comments, dependent: :destroy
  validates :content, presence: true
end
