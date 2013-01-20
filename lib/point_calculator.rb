class PointCalculator

  def initialize division
    @division = division
    @registrations = division.registrations
    # division.valid_matches already filters out any games played over the ruleset game limit
    @matches = division.valid_matches # checks for tagged games by default
    @ruleset = division.point_ruleset

  end

  def calculate
    @matches.each do |match|
      puts "Calculating #{match}..."
      next unless match.tagged
      if match.points.empty?
        give_points_to match.players_by_result, match
      end
    end
  end

  # def deserves_points? match
  #   match.points.any? ? false : true
  # end


  # PointRuleset:
  # parent_id: integer,
  # points_per_win: float,
  # points_per_loss: float,
  # point_decay: float,
  # type: string

  # Point:
  # count: integer
  # account_id: integer
  # event_id: integer
  # event_desc: string
  # event_type: string
  # game_hash: string
  # registration_id: integer
  # enabled: boolean
  # match_id: integer

  def give_points_to players, match

    winner, loser = players[0], players[1]
    match_info = calculate_match_position(match)
    match_position, match_count = match_info[0], match_info[1]

    winner_points = calculate_point_decay(@ruleset.points_per_win, @ruleset.point_decay, match_count, match_position)
    loser_points = calculate_point_decay(@ruleset.points_per_loss, @ruleset.point_decay, match_count, match_position)


    winner.points.create(:count => winner_points,
                         :account_id => winner.account.id,
                         :event_id => winner.event.id,
                         :event_type => winner.event.event_type,
                         :match_id => match.id,
                         :registration_id => winner.id)
    loser.points.create(:count => loser_points,
                        :account_id => loser.account.id,
                        :event_id => loser.event.id,
                        :event_type => loser.event.event_type,
                        :match_id => match.id,
                        :registration_id => loser.id)


  end

  def calculate_point_decay point_value, decay, match_count, match_position
    new_point_value, points = point_value, []
    # binding.pry if match_count == 2 and point_value == 1 and match_position == 2
    count = 1
    while count <= match_count
      if count == 1
        points << point_value
      else
        new_point_value = new_point_value * decay
        points << new_point_value
      end
      count += 1
    end

    # points contains game point values in the order in which the games were played
    points[match_position - 1]
  end

  def calculate_match_position match
    matches = match.similar_and_valid_games
    match_position = matches.index(match) + 1
    [match_position, matches.length]
  end



end