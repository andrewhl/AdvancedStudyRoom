class RemoveHandicapDefaultFromRulesets < ActiveRecord::Migration
  def change
    remove_column :rulesets, :handicap_default
  end
end
