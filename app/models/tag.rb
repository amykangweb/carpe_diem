class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :goals, through: :taggings

  def self.top_tags
    newest = Tag.all.sort_by(&:created_at).reverse.first(40)
    final = newest.sort_by { |t| t.taggings.count }.reverse
  end

  def self.size?(obj)
    arr = Tag.top_tags
    if arr.first(10).include?(obj)
      return 'large'
    elsif arr[10..25].include?(obj)
      return 'medium'
    else
      return 'small'
    end
  end
end
