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
#  name             :string(255)
#

class Division < ActiveRecord::Base
  attr_accessible :month,
                  :division_index,
                  :minimum_players,
                  :maximum_players,
                  :current_players,
                  :safe_position,
                  :promoted_players,
                  :demoted_players,
                  :division_ruleset,
                  :division_ruleset_attributes,
                  :custom_name,
                  :use_custom_name

  validate :less_than_max_players
  validate :greater_than_min_players
  validates_presence_of :minimum_players, :maximum_players

  has_many :accounts
  has_many :registrations
  has_one :division_ruleset, :dependent => :destroy
  belongs_to :tier

  accepts_nested_attributes_for :division_ruleset, allow_destroy: true

  def ruleset
    division_ruleset
  end

  def ruleset?
    !division_ruleset.nil?
  end

  private

    def less_than_max_players
      unless minimum_players.nil?
        errors.add(:minimum_players, "should be less than or equal to maximum number of players") unless minimum_players <= maximum_players
      end
    end

    def greater_than_min_players
      unless maximum_players.nil?
        errors.add(:maximum_players, "should be greater than or equal to minimum number of players") unless maximum_players >= minimum_players
      end
    end
end
