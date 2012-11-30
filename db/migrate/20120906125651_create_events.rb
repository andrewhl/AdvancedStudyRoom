class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer  :ruleset_id
      t.string   :name
      t.datetime :start_time
      t.datetime :end_time
      t.string   :ruleset_name
      t.string   :event_type
      t.integer  :ruleset_default
      t.integer  :league_id
      t.integer  :server_id

      t.timestamps
    end

    add_index :events, :ruleset_id
    add_index :events, :league_id
    add_index :events, :server_id
  end
end
