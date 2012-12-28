class EventsController < ApplicationController
  before_filter :find_event, only: [:show, :manage, :update, :destroy, :results, :tags]

  add_breadcrumb "Events", "/events", except: [:tournaments, :leagues]
  add_breadcrumb "Tournaments", "/tournaments", only: [:tournaments]
  add_breadcrumb "Leagues", "/leagues", only: [:leagues]
  add_breadcrumb "New Event", "/events/new", only: [:new, :create]
  add_breadcrumb "Manage Event", "/events/:id/manage", only: [:manage]
  add_breadcrumb "Event Overview", "/events/:id", only: [:show]
  add_breadcrumb "Results", "/results", only: [:results]


  def new
    @event = Event.new
    @rulesets = Ruleset.canon
    @servers = Server.all
    @event_ruleset = @event.build_event_ruleset
    @tag = Tag.new
    @tags = Tag.select { |tag| !tag.event.nil? }
  end

  def create

    event_params = params[:event].dup
    event_params.delete("event_ruleset")

    tag_params = event_params.delete("tag")

    if params[:event][:tag][:phrase].empty?
      redirect_to :new_event, :flash => { :error => "Tag phrase can not be blank." }
    else

      @event = Event.create(event_params)
      params[:event][:event_ruleset][:parent_id] = params[:event][:ruleset_id]
      @event_ruleset = @event.build_event_ruleset(params[:event][:event_ruleset])
      @event_ruleset.ruleset_id = @event.ruleset.id
      @event_ruleset.save

      @tag = @event.tags.create(tag_params)

      redirect_to :new_event, :flash => {:success => "Your event has been successfully created."}
    end
  end

  def update
    @tags = Tag.all
    @event.update_attribute(:ruleset_id, params[:event][:ruleset_id])
    redirect_to manage_event_path(@event), :flash => { :success => "Ruleset applied." }
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
    @rulesets = Ruleset.canon
  end

  def leagues
    @leagues = Event.leagues
    @registration = Registration.new
  end

  def registrations
  end

  def results
    @tiers = @event.tiers

    unless @tiers.empty? or @tiers.first.divisions.empty?
      params[:division] ||= @tiers.first.divisions.first.name
    end

    @divisions = Division.all.select { |division| division.tier.event == @event }
    @division = @divisions.select { |division| division.name == params[:division] }

    # @division = Division.find(params[:division])

    # @tiers.divisions.select { |division| division.name == params[:division] }

    # Default values for the page sorting.
    params[:sort] ||= "points"
    params[:direction] ||= "desc"
  end

  def tags
    # binding.pry
    @tags = Tag.all
    @tag = @event.tags.build
    if params[:submit]
      binding.pry

    end

  end

  private

    def find_event
      @event = Event.find(params[:id])
    end

end