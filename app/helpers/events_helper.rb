module EventsHelper

  def sort_column
    Registration.column_names.include?(params[:sort]) ? params[:sort] : "points_this_month"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end