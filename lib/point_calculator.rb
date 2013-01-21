class PointCalculator

  def initialize division
    @division = division
    @registrations = division.registrations
    # division.valid_matches already filters out any games played over the ruleset game limit
    @matches = division.valid_matches # checks for tagged games by default
    # reg = Registration.find_by_handle("ufo")
    # @matches = reg.valid_and_tagged_matches
    @ruleset = division.point_ruleset

  end

  def calculate
    @matches.each do |match|
      puts "Calculating #{match}..."
      next unless match.tagged
      # binding.pry
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

    # binding.pry

    winner, loser = players[0], players[1]
    match_info = calculate_match_position(match)
    match_position, match_count = match_info[0], match_info[1]

    winner_points = calculate_point_decay(@ruleset.points_per_win, @ruleset.point_decay, match_count, match_position, match)
    # loser_points = calculate_point_decay(@ruleset.points_per_loss, @ruleset.point_decay, match_count, match_position, match)


    winner.points.create(:count => winner_points,
                         :account_id => winner.account.id,
                         :event_id => winner.event.id,
                         :event_type => winner.event.event_type,
                         :match_id => match.id,
                         :registration_id => winner.id)
    loser.points.create(:count => @ruleset.points_for_game,
                        :account_id => loser.account.id,
                        :event_id => loser.event.id,
                        :event_type => loser.event.event_type,
                        :match_id => match.id,
                        :registration_id => loser.id)
  end

  def calculate_point_decay point_value, decay, match_count, match_position, match
    new_point_value, points = point_value, []
    # binding.pry if match_count == 2 and point_value == 1 and match_position == 2

    # 2/1 then 1/.5 if he won the first, 1.5/.5 if he lost the first

    # Award 0.5 points to both players for every game, regardless
    # [13-01-20 9:23:39 PM] Graham Lamburn: Award 1 for the first win, and (* decay) for each subsequent _win_
    # [13-01-20 9:23:50 PM] Graham Lamburn: That way, the decay is tied to wins, not games

    # binding.pry if match.id == 82
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
    # binding.pry if match.id == 82
    matches = match.similar_and_valid_games
    match_position = matches.index(match) + 1
    [match_position, matches.length]
  end



end