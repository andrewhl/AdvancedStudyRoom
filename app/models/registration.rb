class Registration < ActiveRecord::Base
  attr_accessible :account_id, :event_id, :registration

  belongs_to :event
  belongs_to :account
end
