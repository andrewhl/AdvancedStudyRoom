# == Schema Information
#
# Table name: matches
#
#  id                :integer          not null, primary key
#  match_type        :string(255)
#  ot_type           :string(255)
#  win_info          :string(255)
#  digest            :string(255)
#  url               :string(255)
#  filename          :string(255)
#  black_player_name :string(255)
#  white_player_name :string(255)
#  tags              :string(255)
#  validation_errors :string(255)
#  valid_match       :boolean
#  tagged            :boolean
#  has_points        :boolean          default(FALSE), not null
#  ot_stones_periods :integer
#  black_player_id   :integer
#  white_player_id   :integer
#  division_id       :integer
#  winner_id         :integer
#  loser_id          :integer
#  board_size        :integer
#  handicap          :integer
#  komi              :float
#  main_time_control :float
#  ot_time_control   :float
#  completed_at      :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

#  filename          :string(255)
#  win_info          :string(255)
#  match_type        :string(255)
#  ot_type           :string(255)
#  black_player_name :string(255)
#  white_player_name :string(255)
#  ot_stones_periods :integer
#  board_size        :integer
#  handicap          :integer
#  komi              :float
#  main_time_control :float
#  ot_time_control   :float
#  completed_at      :datetime

#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
#  black_player_id   :integer
#  white_player_id   :integer
#  winner_id         :integer
#  loser_id          :integer

class Match < ActiveRecord::Base
  attr_protected

  validates_uniqueness_of :digest, :on => :create, :message => "must be unique"

  belongs_to :black_player, :class_name => 'Registration'
  belongs_to :white_player, :class_name => 'Registration'
  belongs_to :division
  belongs_to :winner, :class_name => 'Registration', :foreign_key => 'winner_id'
  belongs_to :loser, :class_name => 'Registration', :foreign_key => 'loser_id'

  has_one :event, through: :black_player
  has_many :comments, :autosave => true, :dependent => :destroy
  has_many :points
  has_many :tags, class_name: "MatchTag", :autosave => true, :dependent => :destroy

  scope :unvalidated, where('valid_match IS NULL')
  scope :valid_matches, where("valid_match = ?", true).order("completed_at")
  scope :tagged, where("tagged = ?", true).order("completed_at") # confirmed has tag
  scope :unchecked, lambda { where("tagged IS NULL").order("completed_at") } # not checked for tags
  scope :untagged, where("tagged = ?", false).order("completed_at") # confirmed has no tag
  scope :tagged_and_valid, where("valid_match = ? and tagged = ?", true, true).order("completed_at")
  scope :accepted, where("valid_match = true and tagged = true").order("completed_at")
  scope :by_event, lambda { |e| select('matches.*').joins(:black_player).where('registrations.event_id = ?', e.id) }

  CANADIAN = 'Canadian'
  BYO_YOMI = 'byo-yomi'

  def players
    [white_player, black_player]
  end

  def name
    "#{white_player_name}-#{black_player_name}"
  end

  def players_by_result
    winner = players.select { |player| player.id == winner_id }[0]
    loser = players.select { |player| player.id == loser_id }[0]
    [winner, loser]
  end

  def url(basepath)
    # http://files.gokgs.com/games
    "#{basepath}"
  end

  def byo_yomi?
    ot_type == Match::BYO_YOMI
  end

  def canadian?
    ot_type == Match::CANADIAN
  end

  def division_points event_id
    return nil if points.empty?
    points.select { |point| point.event_id == point.division.event_id }
  end

  def check_tags!
    event_tags = event.tags.collect { |tag| tag.phrase }
    match_tags = tags.split(",")

    update_attribute(:tagged, (event_tags & tags).any?)
  end

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
