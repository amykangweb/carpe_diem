class AddUserIndexToPostsAndEntries < ActiveRecord::Migration
  def change
    add_reference :goals, :user, index: true
    add_reference :entries, :user, index: true
  end
end
