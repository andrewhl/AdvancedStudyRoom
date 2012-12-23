class AddHandicapRequiredToRuleset < ActiveRecord::Migration
  def change
    add_column :rulesets, :handicap_required, :boolean
  end
end
