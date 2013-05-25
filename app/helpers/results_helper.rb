module ResultsHelper

  def active_tab_for(division)
    division.id.to_i == params[:division_id].to_i ? 'active' : ''
  end

  def division_sortable(column, title = nil, division_id = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction, :division_id => division_id}, {:class => css_class}
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
