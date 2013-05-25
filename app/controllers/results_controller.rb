class ResultsController < ApplicationController

  before_filter :initialize_table_sorter

  def index
    @event = Event.find(params[:event_id], include: :tiers)

    tiers = @event.tiers # OPTIMIZE: Possible code smell. Consider refactoring.
    unless tiers.empty? || tiers.first.divisions.empty?
      params[:division] ||= tiers.first.divisions.alphabetical.first
    end

    @division = Division.find(params[:division], include: {registrations: :account})

    match_finder = ASR::MatchFinder.new
    @matches = match_finder.by_division(@division).tagged.valid.with_points
  end

  def no_events
  end

  def main_event
    return redirect_to :no_events unless Event.any?
    redirect_to action: :index, event_id: Event.first.id
  end

  private
    def initialize_table_sorter
      @sorter = TableSorter.new(
        sort_direction: params[:direction] || "desc",
        sort_column: params[:sort] || "points_this_month"
        table: "Registration"
        )
      # params[:sort] ||= "points_this_month"
      # params[:direction] ||= "desc"
    end

end