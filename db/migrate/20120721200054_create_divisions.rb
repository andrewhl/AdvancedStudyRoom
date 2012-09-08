class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.integer  :tier_id
      t.datetime :month
      t.integer  :division_index
      t.integer  :minimum_players
      t.integer  :maximum_players
      t.integer  :current_players
      t.integer  :safe_position
      t.integer  :promoted_players
      t.integer  :demoted_players
    end

    add_index :divisions, :division_index
    add_index :divisions, :tier_id
  end
end

