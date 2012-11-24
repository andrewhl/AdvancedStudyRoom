# == Schema Information
#
# Table name: divisions
#
#  id               :integer          not null, primary key
#  tier_id          :integer
#  month            :datetime
#  division_index   :integer
#  minimum_players  :integer
#  maximum_players  :integer
#  current_players  :integer
#  safe_position    :integer
#  promoted_players :integer
#  demoted_players  :integer
#

class Division < ActiveRecord::Base
  attr_accessible :month, :division_index, :minimum_players, :maximum_players, :current_players, :safe_position, :promoted_players, :demoted_players

  has_many :division_players
  has_one :division_ruleset, :dependent => :destroy
  belongs_to :tier
end
