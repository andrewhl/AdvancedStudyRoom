class ChangeEventTypeToEventTypeId < ActiveRecord::Migration

  def up
    add_column :events, :event_type_id, :integer
    event_type_names = Event.all.collect { |event| event.read_attribute(:event_type).to_s.downcase }.uniq
    event_type_names.each do |event_type_name|
      event_type = EventType.find_or_create_by_name(event_type_name)
      events = Event.where("LOWER(event_type) = LOWER(?)", event_type.name)
      events.each do |event|
        event.update_attribute(:event_type_id, event.id)
      end
    end
    remove_column :events, :event_type
    add_index :events, :event_type_id
  end

  def down
    remove_index :events, :event_type_id
    add_column :events, :event_type, :string
    events = Event.all
    events.each do |event|
      event_type_name = EventType.find(event.event_type_id).name
      event.update_attribute :event_type, event_type_name
      ActiveRecord::Base.connection.execute("UPDATE events SET event_type = '#{event_type_name}' WHERE id = #{event.id}")
    end

    remove_column :events, :event_type_id
  end
end