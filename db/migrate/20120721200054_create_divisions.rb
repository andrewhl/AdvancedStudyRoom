class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.string  :division_name
      t.string  :bracket_suffix
      t.integer :bracket_players_min
      t.integer :bracket_players_max
      t.integer :bracket_number
      t.integer :division_players_min
      t.integer :division_players_max
      t.float   :min_points_required
      t.integer :min_position_required
      t.integer :min_games_required
      t.integer :min_wins_required
      t.integer :max_losses_required
      t.boolean :immunity_boolean
      t.integer :demotion_buffer
      t.integer :promotion_buffer
      t.integer :rules_id
      t.integer :division_hierarchy
    end
  end
end

