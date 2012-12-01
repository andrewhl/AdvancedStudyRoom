class Point < ActiveRecord::Base
  attr_accessible :account_id,
                  :count,
                  :event_desc,
                  :event_type,
                  :event_id

  belongs_to :account
  belongs_to :event

  scope :league_points, where(:event_type => "League")
  scope :tournament_points, where(:event_type => "Tournament")


end
