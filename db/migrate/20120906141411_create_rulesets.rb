class CreateRulesets < ActiveRecord::Migration
  def change
    create_table :rulesets do |t|
      t.string     :name
      t.boolean    :overtime_required
      t.boolean    :handicap_required
      t.boolean    :j_ot_allowed
      t.boolean    :c_ot_allowed
      t.float      :main_time_min
      t.float      :main_time_max
      t.float      :j_ot_min_period_length
      t.float      :j_ot_max_period_length
      t.float      :c_ot_min_time
      t.float      :c_ot_max_time
      t.float      :min_komi
      t.float      :max_komi
      t.integer    :j_ot_max_periods
      t.integer    :j_ot_min_periods
      t.integer    :c_ot_min_stones
      t.integer    :c_ot_max_stones
      t.integer    :min_handicap
      t.integer    :max_handicap
      t.integer    :min_board_size
      t.integer    :max_board_size
      t.integer    :node_limit

      t.references :rulesetable, polymorphic: true

      t.timestamps
    end



  end
end
