class EventsController < ApplicationController
  before_filter :find_event, only: [:show, :manage, :update, :destroy, :results, :tags]
  helper_method :sort_column, :sort_direction

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
    @tiers = @event.tiers.order("tier_hierarchy_position ASC")

    unless @tiers.empty? or @tiers.first.divisions.empty?
      params[:division] ||= @tiers.first.divisions.ranked.first.id
    end

    @divisions = Division.where("event_id = ?", @event.id)
    @division = Division.find(params[:division])

    # get current matches for this division

    @matches = @division.valid_and_tagged_matches.select { |item| item.created_at.month == Time.now.month }

    # @tiers.divisions.select { |division| division.name == params[:division] }

    # Default values for the page sorting.
    params[:sort] ||= "handle"
    params[:direction] ||= "asc"
  end

  def tags
    # binding.pry
    @tags = Tag.all
    @tag = @event.tags.build
    if params[:submit]
      binding.pry

    end

  end

  def validate_games
    respond_to do |format|
      format.js do
        event = Event.find(params[:id])
        event.validate_games
        flash[:success] = "Matches validated."
        render :manage
      end
    end
  end

  def tag_games
    respond_to do |format|
      format.js do
        event = Event.find(params[:id])
        event.tag_games(true)
        flash[:success] = "Matches tagged."
        render :manage
      end
    end
  end

  private

    def find_event
      @event = Event.find(params[:id])
    end

    def sort_column
      Registration.column_names.include?(params[:sort]) ? params[:sort] : "handle"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end