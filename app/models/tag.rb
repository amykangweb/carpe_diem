class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :goals, through: :taggings

  def self.top_tags
    Tag.last(40).sort_by { |t| t.taggings.count }.reverse
  end

  def self.size?(obj)
    arr = Tag.top_tags
    if arr.first(20).include?(obj)
      return 'large'
    else
      return 'medium'
    end
  end
end
