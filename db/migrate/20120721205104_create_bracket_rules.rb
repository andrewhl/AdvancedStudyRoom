class CreateBracketRules < ActiveRecord::Migration
  def change
    create_table :bracket_rules do |t|

      t.timestamps
    end
  end
end
