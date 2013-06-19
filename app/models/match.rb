# == Schema Information
#
# Table name: matches
#
#  id                    :integer          not null, primary key
#  registration_group_id :integer
#  digest                :string(255)
#  url                   :string(255)
#  validation_errors     :string(255)
#  valid_match           :boolean
#  tagged                :boolean
#  has_points            :boolean          default(FALSE), not null
#  completed_at          :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Match < ActiveRecord::Base
  attr_protected

  validates_uniqueness_of :digest, :on => :create, :message => "must be unique"

  belongs_to :registration_group

  has_one :match_detail, dependent: :destroy, autosave: true
  has_one :event, through: :registration_group
  has_many :comments, class_name: "MatchComment", dependent: :destroy, autosave: true
  has_many :points, through: :match_registrations
  has_many :match_registrations, dependent: :destroy, autosave: true
  has_many :registrations, through: :match_registrations
  has_many :tags, class_name: "MatchTag", dependent: :destroy, autosave: true

  scope :unvalidated, where('valid_match IS NULL')
  scope :valid_matches, where("valid_match = ?", true).order("completed_at")
  scope :tagged, where("tagged = ?", true).order("completed_at") # confirmed has tag
  scope :unchecked, lambda { where("tagged IS NULL").order("completed_at") } # not checked for tags
  scope :untagged, where("tagged = ?", false).order("completed_at") # confirmed has no tag
  scope :tagged_and_valid, where("valid_match = ? and tagged = ?", true, true).order("completed_at")
  scope :accepted, where("valid_match = true and tagged = true").order("completed_at")
  scope :by_event, lambda { |e| select('matches.*').joins(:registration_group).where('registration_group.event_id = ?', e.id) }

  CANADIAN = 'Canadian'
  BYO_YOMI = 'byo-yomi'

  # def players
  #   [white_player, black_player]
  # end

  # def name
  #   "#{white_player_name}-#{black_player_name}"
  # end

  # def players_by_result
  #   winner = players.select { |player| player.id == winner_id }[0]
  #   loser = players.select { |player| player.id == loser_id }[0]
  #   [winner, loser]
  # end

  # def url(basepath)
  #   # http://files.gokgs.com/games
  #   "#{basepath}"
  # end


  # def division_points event_id
  #   return nil if points.empty?
  #   points.select { |point| point.event_id == point.division.event_id }
  # end

  # def check_tags!
  #   event_tags = event.tags.collect { |tag| tag.phrase }

  #   update_attribute(:tagged, (event_tags & tags).any?)
  # end

  def accepted?
    valid_match? && tagged?
  end

  def all_errors
    errors = validation_errors.to_s.split(',').collect { |i| i.strip }
    errors << :tags unless tagged?
    errors
  end

  def self.build_digest(args)
    keys = [:white_handle, :black_handle, :completed_at, :win_info]
    args.assert_valid_keys(*keys)
    digest = keys.collect { |k| args[k].to_s.downcase }.join('-')
    Digest::SHA1.base64digest(digest)
  end

end
