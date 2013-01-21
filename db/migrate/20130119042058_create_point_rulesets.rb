class CreatePointRulesets < ActiveRecord::Migration
  def change
    create_table :point_rulesets do |t|
      t.integer :parent_id
      t.string  :parent_type
      t.float   :points_per_win
      t.float   :points_per_loss
      t.float   :point_decay
      t.string  :type

      t.timestamps
    end
    add_index :point_rulesets, :parent_id
  end
end
