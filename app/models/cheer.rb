class Cheer < ActiveRecord::Base
  belongs_to :user
  belongs_to :entry
  validates_uniqueness_of :entry_id, scope: :user_id
end
