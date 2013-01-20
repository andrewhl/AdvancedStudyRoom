class AddParentTypeToPointRulesets < ActiveRecord::Migration
  def change
    add_column :point_rulesets, :parent_type, :string
  end
end
