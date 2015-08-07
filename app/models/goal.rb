class Goal < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  belongs_to :user
  has_many :entries, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings
  validates :description, presence: true, length: { maximum: 40 }

  def cheers_count
    count = 0
    self.entries.each do |entry|
      count += entry.cheering_users.count
    end
    return count
  end

  def completed?
    self.completed == true
  end

  def private?
    self.private == true
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

# tag setter in goal form
  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
