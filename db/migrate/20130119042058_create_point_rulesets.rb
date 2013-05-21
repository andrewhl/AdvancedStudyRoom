class CreatePointRulesets < ActiveRecord::Migration
  def change
    create_table :point_rulesets do |t|
      t.float   :points_per_win
      t.float   :points_per_loss
      t.float   :point_decay
      t.float   :min_points_per_match
      t.integer :max_matches_per_opponent

      t.references :pointable, polymorphic: true

      t.timestamps
    end

    add_index :point_rulesets, [:pointable_type, :pointable_id]

  end
end
