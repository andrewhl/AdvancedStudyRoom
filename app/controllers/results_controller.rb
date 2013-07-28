class ResultsController < ApplicationController

  before_filter :initialize_params
  before_filter :load_event, :load_division, only: [:index, :show]

  def show
    @matches = load_matches(@event)
  end

  def no_events
  end

  def main_event
    return redirect_to :no_events unless Event.live.any?
    redirect_to action: :show, id: Event.live.first.id
  end

  private

    def initialize_params
      params[:sort]      ||= "points_this_month"
      params[:direction] ||= "desc"
    end

    def load_event
      @event = Event.find(params[:id])
    end

    def load_division
      div_id = params[:division_id]
      @division = div_id.blank? ?
                    @event.divisions.first :
                    Division.find(div_id)
    end

    def load_matches(event)
      event.matches.accepted.with_points
    end

end
