class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.boolean :rengo
      t.boolean :teaching
      t.boolean :review
      t.boolean :free
      t.boolean :rated
      t.boolean :demonstration
      t.boolean :unfinished
      t.integer :tag_pos
      t.string  :tag_phrase
      t.boolean :tag_boolean
      t.boolean :ot_boolean
      t.integer :byo_yomi_periods
      t.integer :byo_yomi_seconds
      t.string  :ruleset
      t.boolean :ruleset_boolean
      t.float   :komi
      t.boolean :komi_boolean
      t.string  :handicap
      t.boolean :handicap_boolean
      t.integer :max_games
      t.float   :points_per_win
      t.float   :points_per_loss
      t.integer :main_time
      t.boolean :main_time_boolean
      t.string  :month
      t.integer :canadian_stones
      t.integer :canadian_time
      t.integer :number_of_divisions
      t.string  :time_system
      t.boolean :division_boolean
      t.string  :board_size
      t.boolean :board_size_boolean

      t.timestamps
    end
  end
end