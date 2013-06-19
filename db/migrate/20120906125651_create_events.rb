class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string    :name, limit: 100
      t.text      :description
      t.text      :prizes_description
      t.integer   :event_type_id
      t.integer   :server_id
      t.datetime  :starts_at
      t.datetime  :ends_at
      t.datetune  :opens_at
      t.datetime  :closes_at

      t.timestamps
    end

    add_index :events, :server_id
  end
end