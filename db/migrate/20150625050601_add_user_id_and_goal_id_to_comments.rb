class AddUserIdAndGoalIdToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :user, index: true
    add_reference :comments, :goal, index: true
  end
end
