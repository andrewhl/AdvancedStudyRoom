class CreateTierTypes < ActiveRecord::Migration
  def change
    create_table :tier_types do |t|
      t.string :name
      t.integer :default_promotions
      t.integer :default_demotions
      t.integer :tier_hierarchy_position
      t.integer :default_divisions
      t.integer :max_games_per_player
      t.integer :max_games_per_opponent
      t.float :points_per_win
      t.float :points_per_loss

      t.timestamps
    end

  end
end
