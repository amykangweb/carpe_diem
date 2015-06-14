class User < ActiveRecord::Base
  has_many :goals, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :cheers, dependent: :destroy
  has_many :cheered_entries, through: :cheers, source: :entry
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :followed_by, class_name: 'Friendship',
  foreign_key: 'friend_id'
  has_many :followers, through: :followed_by, source: :user
  validates :username, presence: true
  validates_uniqueness_of :username
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def following?(user)
    self.friendships.find_by(friend_id: user.id).present?
  end

  def activity
    all = []
    self.friendships.each do |user|
      user.friend.goals.each do |items|
        all << items
        items.entries.each do |entry|
          all << entry
        end
      end
    end
    @all = all.sort_by(&:created_at).reverse
  end
end
