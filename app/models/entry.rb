class Entry < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  belongs_to :user
  belongs_to :goal
  has_many :cheers, dependent: :destroy
  has_many :cheering_users, through: :cheers, source: :user
  has_many :comments, dependent: :destroy
  validates :content, presence: true

  def cheered?(user)
    if self.cheering_users.include?(user)
      return true
    else
      return false
    end
  end
end
