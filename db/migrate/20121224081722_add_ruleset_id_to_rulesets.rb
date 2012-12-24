class AddRulesetIdToRulesets < ActiveRecord::Migration
  def change
    add_column :rulesets, :ruleset_id, :integer
    add_index  :rulesets, :ruleset_id
  end
end
