class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string  :phrase
      t.integer :league_id
      t.integer :event_id
      t.integer :node_limit

      t.timestamps
    end

    add_index :tags, :league_id
    add_index :tags, :event_id
  end
end
