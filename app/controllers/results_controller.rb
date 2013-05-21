class ResultsController < ApplicationController

  before_filter :initialize_params

  def index
    @event = Event.find(params[:event_id], include: :tiers)

    tiers = @event.tiers # OPTIMIZE: Possible code smell. Consider refactoring.
    unless tiers.empty? || tiers.first.divisions.empty?
      params[:division_id] ||= tiers.first.divisions.alphabetical.first.id
    end

    @division = @event.divisions.find(params[:division_id], include: {registrations: :account})

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
    def initialize_params
      params[:sort] ||= "points_this_month"
      params[:direction] ||= "desc"
    end

end