class CreateDivisionRules < ActiveRecord::Migration
  def change
    create_table :division_rules do |t|

      t.timestamps
    end
  end
end
