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
  # attr_accessible :title, :body

  has_many :division_players
  belongs_to :tier
end
