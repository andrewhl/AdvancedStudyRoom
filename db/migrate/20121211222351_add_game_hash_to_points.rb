class AddGameHashToPoints < ActiveRecord::Migration
  def change
    add_column :points, :game_hash, :string
    add_column :points, :registration_id, :integer
    add_column :points, :enabled, :boolean
    add_index :points, :game_hash
  end

end
