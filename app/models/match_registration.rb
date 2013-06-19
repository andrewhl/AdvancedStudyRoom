# == Schema Information
#
# Table name: match_registrations
#
#  id              :integer          not null, primary key
#  match_id        :integer
#  registration_id :integer
#  white           :boolean
#  black           :boolean
#  winner          :boolean
#  loser           :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class MatchRegistration < ActiveRecord::Base
  belongs_to :match

  has_one :registration
  has_one :point, as: :pointable, dependent: :destroy, autosave: true
end
