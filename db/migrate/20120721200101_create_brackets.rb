class CreateBrackets < ActiveRecord::Migration
  def change
    create_table :brackets do |t|
      t.integer :division_id
      t.integer :min_players
      t.integer :max_players
      t.integer :division_pos
      t.float   :min_points_required
      t.integer :min_position_required
      t.integer :min_games_required
      t.integer :min_wins_required
      t.integer :max_losses_required
      t.boolean :immunity_boolean
      t.integer :demotion_buffer
      t.integer :promotion_buffer
      t.string :name
      t.string :suffix

      t.timestamps
    end
  end
end