class CreateEventTags < ActiveRecord::Migration
  def change
    create_table :event_tags do |t|
      t.string  :phrase
      t.integer :event_id
      t.integer :node_limit

      t.timestamps
    end

    add_index :event_tags, :phrase
    add_index :event_tags, :event_id
  end
end
