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
#  node_limit :integer
#

class Tag < ActiveRecord::Base
  attr_protected

  belongs_to :league
  belongs_to :event

  validates_uniqueness_of :phrase
  # validates_presence_of :event_id
  validates_presence_of :node_limit
end
