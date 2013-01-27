class AddPointsThisMonthToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :points_this_month, :float
  end
end
