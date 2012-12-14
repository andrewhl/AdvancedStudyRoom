class CreateTiers < ActiveRecord::Migration
  def change
    create_table :tiers do |t|
      t.integer :tier_type_id
      t.integer :promotions
      t.integer :demotions
      t.integer :tier_hierarchy_position
      t.integer :divisions
      t.integer :max_games_per_player
      t.integer :max_games_per_opponent
      t.float   :points_per_win
      t.float   :points_per_loss
      t.integer :event_id
      t.integer :league_id
      t.string  :name
      t.integer :parent_id
      t.integer :child_id

      t.timestamps
    end

    add_index :tiers, :tier_type_id
    add_index :tiers, :event_id
    add_index :tiers, :league_id
    add_index :tiers, :parent_id
    add_index :tiers, :child_id
  end
end