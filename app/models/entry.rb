class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal
  has_many :cheers, dependent: :destroy
  has_many :cheering_users, through: :cheers, source: :user
  validates :content, presence: true
end
