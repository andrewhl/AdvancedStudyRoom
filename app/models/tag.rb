# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  phrase     :string(255)
#  league_id  :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  attr_accessible :phrase, :league_id, :event_id

  belongs_to :league
  belongs_to :event
end
