class AddPointsForGameToPointRuleset < ActiveRecord::Migration
  def change
    add_column :point_rulesets, :points_for_game, :float
  end
end
