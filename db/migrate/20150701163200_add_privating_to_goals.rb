class AddPrivatingToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :private, :boolean, default: false
  end
end
