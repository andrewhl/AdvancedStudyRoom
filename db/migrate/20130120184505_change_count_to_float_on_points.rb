class ChangeCountToFloatOnPoints < ActiveRecord::Migration
  def change
    remove_column :points, :count
    add_column    :points, :count, :float
  end
end
