class ResultsController < ApplicationController

  # before_filter :initialize_table_sorter
  before_filter :initialize_params

  def index
    @event = Event.find(params[:event_id], include: :tiers)

    tiers = @event.tiers # OPTIMIZE: Possible code smell. Consider refactoring.
    unless tiers.empty? || tiers.first.divisions.empty?
      params[:division_id] ||= tiers.first.divisions.alphabetical.first.id
    end

    @division = Division.find(params[:division_id], include: {registrations: :account, matches: nil})
    @game_percentage = calculate_matches_percentage(@division)

    match_finder = ASR::MatchFinder.new(event: @event)
    @matches = match_finder.by_division(@division).tagged.valid.with_points
  end

  def no_events
  end

  def main_event
    return redirect_to :no_events unless Event.any?
    redirect_to action: :index, event_id: Event.first.id
  end

  private
    def initialize_params
      params[:sort]      ||= "points_this_month"
      params[:direction] ||= "desc"
    end

    def calculate_matches_percentage(division)
      x = division.registrations.count.to_f
      y = division.point_rules[:max_matches_per_opponent].to_f
      max_possible_matches = ((x ** 2 - x) / 2) * y

      div_matches = division.matches.count.to_f
      ((div_matches / max_possible_matches) * 100).to_s[0..2]
    end

end