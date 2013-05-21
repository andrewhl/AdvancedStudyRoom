class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string   :name
      t.string   :event_type
      t.integer  :server_id

      t.timestamps
    end

    add_index :events, :server_id
  end
end
