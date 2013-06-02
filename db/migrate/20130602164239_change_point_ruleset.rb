class ChangePointRuleset < ActiveRecord::Migration
  def up
    add_column    :point_rulesets, :win_decay, :float
    add_column    :point_rulesets, :loss_decay, :float
    remove_column :point_rulesets, :point_decay
  end

  def down
    remove_column :point_rulesets, :win_decay
    remove_column :point_rulesets, :loss_decay
    add_column    :point_rulesets, :point_decay, :float
  end
end
