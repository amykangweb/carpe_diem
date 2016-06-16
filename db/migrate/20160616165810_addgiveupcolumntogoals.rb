class Addgiveupcolumntogoals < ActiveRecord::Migration
  def change
    add_column :goals, :give_up, :boolean, default: false
  end
end
