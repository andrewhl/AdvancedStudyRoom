class CreatePointRulesets < ActiveRecord::Migration
  def change
    create_table :point_rulesets do |t|
      t.float   :points_per_win
      t.float   :points_per_loss
      t.float   :win_decay
      t.float   :loss_decay
      t.float   :min_points_per_match
      t.integer :max_matches_per_opponent

      t.references :point_rulesetable, polymorphic: true

      t.timestamps
    end

    add_index :point_rulesets, [:point_rulesetable_type, :point_rulesetable_id], name: "point_rulesets_on_point_rulesetable"

  end
end