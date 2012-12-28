class AddActiveToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :active, :boolean
  end
end
