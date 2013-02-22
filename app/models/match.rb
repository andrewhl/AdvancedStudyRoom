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
#  winner_name        :string(255)
#  winner_id          :integer
#  loser_name         :string(255)
#  loser_id           :integer
#  board_size         :integer
#  valid_game         :boolean
#  tagged             :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Match < ActiveRecord::Base
  attr_protected

  validates_uniqueness_of :game_digest, :on => :create, :message => "must be unique"

  belongs_to :black_player, :class_name => 'Registration'
  belongs_to :white_player, :class_name => 'Registration'
  belongs_to :division

  has_many :comments, :dependent => :destroy
  has_many :points

  scope :valid_games, where("valid_game = ?", true).order("datetime_completed")
  scope :tagged, where("tagged = ?", true).order("datetime_completed") # confirmed has tag
  scope :unchecked, lambda { where("tagged = NULL").order("datetime_completed") } # not checked for tags
  scope :untagged, where("tagged = ?", false).order("datetime_completed") # confirmed has no tag
  scope :tagged_and_valid, where("valid_game = ? and tagged = ?", true, true).order("datetime_completed")

  def players
    [white_player, black_player]
  end

  def players_by_result
    winner = players.select { |player| player.id == winner_id }[0]
    loser = players.select { |player| player.id == loser_id }[0]
    [winner, loser]
  end

  # get all the
  def similar_games tagged=true

    # assumes the game is tagged
    if tagged
      current_matches = Match.tagged.select { |match| match.datetime_completed.year == Time.now.year and match.datetime_completed.month == Time.now.month}
    else # if tagged parameter is false
      current_matches = Match.all.select { |match| match.datetime_completed.year == Time.now.year and match.datetime_completed.month == Time.now.month}
    end

    matches = compile_matches(current_matches)
  end

  def similar_and_valid_games
    current_matches = Match.tagged_and_valid.select { |match| match.datetime_completed.year == Time.now.year and match.datetime_completed.month == Time.now.month}

    matches = compile_matches(current_matches)
  end

  # NOTE: compile_matches seems to do the same thing as same_players. Not sure what its O(n) profile is
  def compile_matches current_matches
    matches = current_matches.select { |match| match.black_player_id == black_player_id and match.white_player_id == white_player_id }
    matches += current_matches.select { |match| match.black_player_id == white_player_id and match.white_player_id == black_player_id }
    matches.sort_by { |match| match.datetime_completed }
  end

  def division_points event_id
    return nil if points.empty?
    points.select { |point| point.event_id == point.division.event_id }
  end

  # get all the games for this month with the same black and white players
  # will only find tagged games by default
  # def same_players tagged=true
  #   games = current_games(tagged)
  #   games.select do |game|
  #     checked_players = Set[game.white_player, game.black_player]
  #     own_players = Set[white_player, black_player]
  #     checked_players.subset? own_players
  #   end
  #   games
  # end

  # check if this game has a valid tag
  def has_valid_tag?
    event = division.event
    registrations = event.registrations
    tags = event.tags

    valid_tag = false

    if comments.nil?
      return valid_tag
    end

    tags.each do |tag|
      node_limit ||= tag.node_limit
      phrase = Regexp.new(tag.phrase, true)

      comments.each do |comment|

        # ensure the comment is made by someone in the event
        next unless registrations.find_by_handle(comment.handle.downcase)

        comment_node = comment.node_number + 1
        return valid_tag = true if phrase =~ comment.comment and (comment_node <= tag.node_limit)
        # return valid_tag if valid_tag == true

        # TODO: handle nil objects (either comment_node or node_limit)
        binding.pry if comment_node.nil? or tag.node_limit.nil?

        break if comment_node > tag.node_limit

      end

    end

    return valid_tag


  end

  # TODO: Add test for games_per_player
  # TODO: Add test for games_per_opponent
  # TODO: Add tests for points

  def is_valid?
    division_ruleset = self.division.division_ruleset

    # binding.pry if division_ruleset.nil?
    # binding.pry if division_ruleset.parent.nil?
    # binding.pry if division_ruleset.parent.parent.nil?

    tier_ruleset = division_ruleset.parent
    event_ruleset = tier_ruleset.parent
    ruleset = event_ruleset.parent

    # check_rulesets returns true or false
    check_rulesets(division_ruleset)


  end



  def check_rulesets ruleset

    game_status = false

    return false if main_time_control.nil? # TODO: incorporate permissions so main_time_control is conditionally checked

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
    # binding.pry if white_player_name == "affytaffy"
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

end
