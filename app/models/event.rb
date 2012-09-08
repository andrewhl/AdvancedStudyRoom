class Event < ActiveRecord::Base
  attr_accessible :end_time, :name, :start_time, :type

  belongs_to :event_type
end
