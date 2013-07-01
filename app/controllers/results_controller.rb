class ResultsController < ApplicationController

  before_filter :initialize_params
  before_filter :load_event, :load_division, only: [:index]

  def index
    match_finder = ASR::MatchFinder.new(event: @event)
    @matches = @event.matches.accepted.with_points #match_finder.by_division(@division).accepted.with_points
  end

  def no_events
  end

  def main_event
    return redirect_to :no_events unless Event.any?
    redirect_to action: :index, event_id: Event.first(order: 'ends_at DESC').id
  end

  private

    def initialize_params
      params[:sort]      ||= "points_this_month"
      params[:direction] ||= "desc"
    end

    def load_event
      @event = Event.find(params[:event_id])
    end

    def load_division
      div_id = params[:division_id]
      @division = div_id.blank? ?
                    @event.divisions.first :
                    Division.find(div_id)
    end

end