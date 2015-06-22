class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :entries, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings
  validates :description, presence: true

  def self.tagged_with(name)
    Tag.find_by_name!(name).goals
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
