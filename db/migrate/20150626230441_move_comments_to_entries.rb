class MoveCommentsToEntries < ActiveRecord::Migration
  def change
    remove_column :comments, :goal_id
    add_reference :comments, :entry, index: true
  end
end
