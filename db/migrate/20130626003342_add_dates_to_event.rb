class AddDatesToEvent < ActiveRecord::Migration
  def change
    add_column :events, :starts_at, :datetime
    add_column :events, :ends_at, :datetime
    add_column :events, :opens_at, :datetime
    add_column :events, :closes_at, :datetime
  end
end
