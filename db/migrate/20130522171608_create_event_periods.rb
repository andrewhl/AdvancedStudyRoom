class CreateEventPeriods < ActiveRecord::Migration
  def change
    create_table :event_periods do |t|
      t.string :name
      t.datetime :starting_at
      t.datetime :ending_at
      t.integer :event_id

      t.timestamps
    end
  end
end
