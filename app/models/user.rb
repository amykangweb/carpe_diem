class User < ActiveRecord::Base
  has_many :goals, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :cheers, dependent: :destroy
  has_many :cheered_entries, through: :cheers, source: :entry
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :reverse_relationship, class_name: 'Friendship',
  foreign_key: 'friend_id'
  has_many :followers, through: :reverse_relationship, source: :user
  validates :username, presence: true
  validates_uniqueness_of :username
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def to_param
    username
  end

  def completed_goals
    self.goals.where(completed: true).count
  end

  def following?(user)
    self.friendships.find_by(friend_id: user.id).present?
  end

  def activity
    all = []
    self.friendships.each do |user|
      user.friend.goals.each do |item|
        unless item.private == true
          all << item
          item.entries.each do |entry|
            all << entry
          end
        end
      end
    end
    all.sort_by(&:created_at).reverse
  end
end
