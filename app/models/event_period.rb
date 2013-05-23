class EventPeriod < ActiveRecord::Base
  attr_accessible :ending_at, :event_id, :name, :starting_at
end
