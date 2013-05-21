class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.integer  :tier_id
      t.integer  :index
      t.integer  :minimum_players
      t.integer  :maximum_players
      t.string   :name
    end

    add_index :divisions, :index
    add_index :divisions, :tier_id
  end
end

