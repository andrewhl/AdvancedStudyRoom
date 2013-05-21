# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  event_type :string(255)
#  server_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class Event < ActiveRecord::Base

  belongs_to :server

  has_one :ruleset, as: :rulesetable, dependent: :destroy
  has_one :point_ruleset, as: :pointable, dependent: :destroy

  has_many :accounts, through: :registrations
  has_many :divisions, through: :tiers, order: '"tiers"."index" ASC, "divisions"."index" ASC'
  has_many :points, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :tags, class_name: 'EventTag', dependent: :destroy, order: 'phrase ASC'
  has_many :tiers, dependent: :destroy, order: '"tiers"."index" ASC'

  attr_accessible :ruleset_id,
                  :name,
                  :start_time
                  :end_time
                  :event_type
                  :server
                  :locked
                  :ruleset_attributes

  accepts_nested_attributes_for :tiers, allow_destroy: true
  accepts_nested_attributes_for :ruleset, allow_destroy: true
  accepts_nested_attributes_for :registrations, allow_destroy: true
  accepts_nested_attributes_for :tags

  scope :leagues, where(event_type: 'League')
  scope :tournaments, where(event_type: 'Tournament')

  def ruleset_id=(id)
    self.ruleset = Ruleset.find(id)
  end

  def ruleset_id
    self.ruleset.try :id
  end

  def ruleset?
    ruleset.present?
  end

  def player_count
    registrations.count
  end

  def matches
    matches = []
    divisions.each do |division|
      matches << division.matches
    end
    matches.flatten
  end

  def validate_matches!
    divisions.each(&:validate_matches!)
  end

  def tag_games force=false

    matches.each do |match|
      unless force
        next unless match.tagged.nil?
      end

      match.update_attribute(:tagged, match.has_valid_tag?)
    end
  end


end
