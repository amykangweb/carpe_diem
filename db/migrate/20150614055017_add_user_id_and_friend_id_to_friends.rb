class AddUserIdAndFriendIdToFriends < ActiveRecord::Migration
  def change
    add_reference :friends, :user, index: true
    add_column :friends, :friend_id, :integer
  end
end
