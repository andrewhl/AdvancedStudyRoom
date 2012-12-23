class AddHandicapToRuleset < ActiveRecord::Migration
  def change
    add_column :rulesets, :max_handi, :integer
    add_column :rulesets, :min_handi, :integer
  end
end
