class AddMatchIdToPoints < ActiveRecord::Migration
  def change
    add_column :points, :match_id, :integer
  end
end
