class CreateEventTags < ActiveRecord::Migration
  def change
    create_table :event_tags do |t|
      t.string  :phrase, limit: 100
      t.integer :event_id, null: false
      t.integer :node_limit

      t.timestamps
    end

    add_index :event_tags, :phrase
    add_index :event_tags, :event_id
  end
end
