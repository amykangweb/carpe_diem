class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :entries, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings
  validates :description, presence: true

  def private?
    self.private == true
  end

# All goals tagged with name arg
  def self.tagged_with(name)
    Tag.find_by_name!(name).goals
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
