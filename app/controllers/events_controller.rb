class EventsController < ApplicationController
  before_filter :find_event, only: [:show, :manage, :destroy, :results]

  add_breadcrumb "Events", "/events", except: [:tournaments, :leagues]
  add_breadcrumb "Tournaments", "/tournaments", only: [:tournaments]
  add_breadcrumb "Leagues", "/leagues", only: [:leagues]
  add_breadcrumb "New Event", "/events/new", only: [:new, :create]
  add_breadcrumb "Manage Event", "/events/:id/manage", only: [:manage]
  add_breadcrumb "Event Overview", "/events/:id", only: [:show]
  add_breadcrumb "Results", only: [:results]


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
    redirect_to :new_event, :flash => {:success => "Your event has been successfully created."}
  end

  def destroy
    @event.destroy

    respond_to do |format|
      format.js
    end
  end

  def index
    @events = Event.all
  end

  def show
    @tier = Tier.new
    @tiers = @event.tiers
    @division = Division.new
    @divisions = @tier.divisions
  end

  def manage
    @tier = Tier.new
    @tiers = @event.tiers
    @division = Division.new
    @divisions = @tier.divisions
  end

  def leagues
    @leagues = Event.leagues
    @registration = Registration.new
  end

  def registrations
  end

  def results
    @tiers = @event.tiers

    params[:division] ||= @tiers.first.divisions.first.name

    # Default values for the page sorting.
    params[:sort] ||= "points"
    params[:direction] ||= "desc"
  end

  private

    def find_event
      @event = Event.find(params[:id])
    end

end