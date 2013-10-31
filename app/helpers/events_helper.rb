module EventsHelper

  def sort_column
    if params[:sort] == "handle"
      "LOWER(accounts.handle)"
    elsif Registration.column_names.include?(params[:sort])
       params[:sort]
    else
      "active DESC, points_this_month"
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end