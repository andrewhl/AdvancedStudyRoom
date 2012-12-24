# == Schema Information
#
# Table name: matches
#
#  id                 :integer          not null, primary key
#  datetime_completed :datetime
#  game_type          :string(255)
#  komi               :float
#  winner             :string(255)
#  win_info           :string(255)
#  main_time_control  :float
#  overtime_type      :string(255)
#  ot_stones_periods  :integer
#  ot_time_control    :float
#  url                :string(255)
#  black_player_id    :integer
#  white_player_id    :integer
#  black_player_name  :string(255)
#  white_player_name  :string(255)
#  handicap           :integer
#  game_digest        :string(255)
#  division_id        :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Match < ActiveRecord::Base
  attr_accessible :datetime_completed,
                  :game_type,
                  :komi,
                  :main_time_control,
                  :ot_stones_periods,
                  :ot_time_control,
                  :overtime_type,
                  :result,
                  :url,
                  :winner,
                  :win_info,
                  :black_player,
                  :white_player,
                  :handicap,
                  :black_player_name,
                  :white_player_name,
                  :game_digest,
                  :black_player_id,
                  :white_player_id,
                  :division_id

  validates_uniqueness_of :game_digest, :on => :create, :message => "must be unique"

  belongs_to :black_player, :class_name => 'Registration'
  belongs_to :white_player, :class_name => 'Registration'
  belongs_to :division

  has_many :comments, :dependent => :destroy
  has_many :points


  def has_valid_tag comments

    # TO DO: TEST IF THE NODE LIMIT WORKS ON A GAME WITH A TAG THAT APPEARS
    # AFTER NODE 0

    valid_tag = false

    comments.each do |node, line|
      next if line.is_a? String
      line.each do |key, value|

        # binding.pry
        # see if tag exists that matches the current line's comment
        if Tag.where("phrase like ?", value[:comment]).exists?
          tag = Tag.where("phrase like ?", value[:comment]).first
          valid_tag = true
          node_limit ||= tag.node_limit

        end

        # check node limit (i.e., move limit in which tag phrase must appear)
        if node_limit
          # returns false if the current node key (when parsed) is greater than the node limit
          return false if node.to_s.scan(/\d/).pop.to_i > node_limit
        end


      end

      return valid_tag
    end

  end

  def is_valid?

    division_ruleset = self.division.division_ruleset
    tier_ruleset = division_ruleset.parent
    event_ruleset = tier_ruleset.parent
    ruleset = event_ruleset.parent

    # check_rulesets returns true or false
    check_rulesets(division_ruleset)


    #  datetime_completed :datetime
    #  game_type          :string(255)
    #  komi               :float
    #  winner             :string(255)
    #  win_info           :string(255)
    #  main_time_control  :float
    #  overtime_type      :string(255)
    #  ot_stones_periods  :integer
    #  ot_time_control    :float
    #  url                :string(255)
    #  black_player_id    :integer
    #  white_player_id    :integer
    #  black_player_name  :string(255)
    #  white_player_name  :string(255)
    #  handicap           :integer
    #  game_digest        :string(255)

  end

  def check_rulesets ruleset

    game_status = false

    methods = [:main_time_min,
               :main_time_max,
               :overtime_required,
               :jovertime_allowed,
               :covertime_allowed,
               :jot_min_periods,
               :jot_max_periods,
               :jot_min_period_length,
               :jot_max_period_length,
               :cot_min_stones,
               :cot_max_stones,
               :cot_max_time,
               :cot_min_time,
               :games_per_opponent,
               :max_komi,
               :min_komi,
               :max_handi,
               :min_handi,
               :handicap_required]

    methods.each do |method|


      check_ruleset = ruleset

      # if the ruleset method has been set, check it
      if !check_ruleset.send(method).nil?
        game_status = check_method(method, check_ruleset)
        return game_status if game_status == false
      end

      # if the method is nil, and the ruleset is not the top level
      # proceed to the parent ruleset to check the method

      while check_ruleset.send(method).nil? and !check_ruleset.is_top_level?
        # binding.pry if ruleset.parent.parent.parent.nil? and check_ruleset.type == "EventRuleset"
        check_ruleset = check_ruleset.parent unless check_ruleset.is_top_level?

        # in the unlikely event that the canonical ruleset has been deleted
        # then it means the method is nil and we should move to the next one
        # note: it will never be possible for non-top-level rulesets to be nil

        if check_ruleset.nil?
          game_status = true
          break
        else

          if check_ruleset.send(method)
            game_status = check_method(method, check_ruleset)
            return game_status if game_status == false
          end
          game_status = true if check_ruleset.send(method).nil? and check_ruleset.is_top_level?

        end
      end

    end
    game_status
  end

  def check_method method, ruleset
    # binding.pry if method == :max_handi
    case method
    when :main_time_max
      main_time_control > ruleset.main_time_max ? false : true
    when :main_time_min
      main_time_control < ruleset.main_time_min ? false : true
    when :overtime_required
      if ruleset.overtime_required
        (overtime_type and ot_stones_periods and ot_time_control) ? true : false
      else
        true
      end
    when :jovertime_allowed
      if !ruleset.jovertime_allowed
        overtime_type == "byo-yomi" ? false : true
      else
        true
      end
    when :covertime_allowed
      if !ruleset.covertime_allowed
        overtime_type == "Canadian" ? false : true
      else
        true
      end
    when :jot_max_periods
      if overtime_type == "byo_yomi"
        ot_stones_periods > ruleset.jot_max_periods ? false : true
      else
        true
      end
    when :jot_min_periods
      if overtime_type == "byo_yomi"
        ot_stones_periods < ruleset.jot_min_periods ? false : true
      else
        true
      end
    when :jot_max_period_length
      if overtime_type == "byo_yomi"
        ot_time_control > ruleset.jot_max_period_length ? false : true
      else
        true
      end
    when :jot_min_period_length
      if overtime_type == "byo_yomi"
        ot_time_control < ruleset.jot_min_period_length ? false : true
      else
        true
      end
    when :cot_max_stones
      if overtime_type == "Canadian"
        ot_stones_periods > ruleset.cot_max_stones ? false : true
      else
        true
      end
    when :cot_min_stones
      if overtime_type == "Canadian"
        ot_stones_periods < ruleset.cot_min_stones ? false : true
      else
        true
      end
    when :cot_max_time
      if overtime_type == "Canadian"
        ot_time_control > ruleset.cot_max_time ? false : true
      else
        true
      end
    when :cot_min_time
      if overtime_type == "Canadian"
        ot_time_control < ruleset.cot_min_time ? false : true
      else
        true
      end
    when :max_komi
      # binding.pry if ruleset.name == "Division Ruleset"
      komi > ruleset.max_komi ? false : true
    when :min_komi
      komi < ruleset.min_komi ? false : true
    when :max_handi
      handicap > ruleset.max_handi ? false : true
    when :min_handi
      handicap < ruleset.min_handi ? false : true
    when :handicap_required
      if ruleset.handicap_required
        handicap > 0 ? true : false
      else
        true
      end
    when :games_per_opponent
      # binding.pry if ruleset.name == "Division Ruleset"
      similar_games.count > ruleset.games_per_opponent ? false : true
    end
  end

  def similar_games
    current_matches = Match.all.select { |match| match.datetime_completed.year == Time.now.year and match.datetime_completed.month == Time.now.month}
    matches = current_matches.select { |match| match.black_player_id == black_player_id and match.white_player_id == white_player_id }
    matches += current_matches.select { |match| match.black_player_id == white_player_id and match.white_player_id == black_player_id }
    matches
  end
end
