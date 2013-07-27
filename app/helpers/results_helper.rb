module ResultsHelper

  def active_tab_for(division)
    division.id.to_i == @division.id.to_i ? 'active' : ''
  end

  def matches_percentage(division)
    # OPTIMIZE: Cache this value instead
    return @matches_percentage if @matches_percentage
    x = division.registrations.count.to_f
    y = division.point_rules[:max_matches_per_opponent].to_f
    max_possible_matches = ((x ** 2 - x) / 2) * y

    div_matches = division.matches.accepted.count.to_f
    @matches_percentage = ((div_matches / max_possible_matches) * 100).to_s[0..2]
  end

  def display_column_matches(matches, row_player, column_player)
    matches.select { |game|
      (row_player.id == game.black_player_id ||
      row_player.id == game.white_player_id) &&
      (column_player.id == game.black_player_id ||
      column_player.id == game.white_player_id) }
  end

  def match_url(match)
    dc = match.completed_at
    "http://files.gokgs.com/games/#{dc.year}/#{dc.month}/#{dc.day}/#{match.filename}"
  end

  def get_matches_for_reg(matches, reg)
    matches.select { |m| m.black_player_id == reg.id || m.white_player_id == reg.id }
  end

  # def sort_column
  #   Registration.column_names.include?(params[:sort]) ? params[:sort] : "points_this_month"
  # end

  # def sort_direction
  #   %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  # end

end
