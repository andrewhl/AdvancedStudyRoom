class CreateEventPeriods < ActiveRecord::Migration
  def change
    create_table :event_periods do |t|
      t.integer  :event_id
      t.datetime :starts_at
      t.datetime :ends_at
      t.datetime :opens_at
      t.datetime :closes_at

      t.timestamps
    end

    add_index :event_periods, :event_id
  end
end
