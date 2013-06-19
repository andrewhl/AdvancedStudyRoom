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

require 'spec_helper'

describe MatchRegistration do
  pending "add some examples to (or delete) #{__FILE__}"
end
