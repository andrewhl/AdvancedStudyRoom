class EventsController < ApplicationController

  add_breadcrumb "New Event", "/events/new", only: [:new, :create]

  def new
    @event = Event.new
    @rulesets = Ruleset.canon
    @servers = Server.all
    @event_ruleset = @event.build_event_ruleset
  end

  def create
    event_params = params[:event].dup
    event_params.delete("event_ruleset")
    @event = Event.create(event_params)
    @event_ruleset = @event.create_event_ruleset(params[:event][:event_ruleset])
    redirect_to :new_event, :notice => "Your event has been successfully created."
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to :events, :notice => "The event has been deleted."
  end

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @tier = Tier.new
    @tiers = @event.tiers
    @division = Division.new
    @divisions = @tier.divisions
  end

  def leagues
    @leagues = Event.leagues
  end

end