class ChangeEventTypeOnPoints < ActiveRecord::Migration
  def up
    remove_index  :points, :event_id
    remove_column :points, :event_type
    remove_column :points, :event_id
  end

  def down
    add_column :points, :event_type, :string
    add_column :points, :event_id, :integer
    add_index  :points, :event_id
  end
end
