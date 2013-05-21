class UpdateRegistrationsForPointsThisMonth < ActiveRecord::Migration
  def up
    remove_column :registrations, :points_this_month
    add_column    :registrations, :points_this_month, :float, null: false, default: 0
  end

  def down
    remove_column :registrations, :points_this_month
    add_column    :registrations, :points_this_month, :float
  end
end
