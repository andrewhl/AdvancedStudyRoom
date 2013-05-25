class EventsController < ApplicationController

  load_and_authorize_resource
  before_filter :authorize, except: [:leagues]

  before_filter :find_event, only: [:manage, :update, :destroy, :join, :quit, :results]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(
      params[:id],
      include: [:tags, {tiers: [:registrations, :divisions]}])
  end

  def manage
    @tier = Tier.new
    @tiers = @event.tiers
    @division = Division.new
    @divisions = @tier.divisions
    @rulesets = Ruleset.all
  end

  def new
    @event = Event.new
    @rulesets = Ruleset.all
    @servers = Server.all
    @ruleset = @event.build_ruleset
    @tag = EventTag.new
    @tags = EventTag.select { |tag| !tag.event.nil? }
  end

  def create
    event_params = params[:event].dup
    event_params.delete("event_ruleset")

    tag_params = event_params.delete("tag")

    if params[:event][:tag][:phrase].empty?
      redirect_to :new_event, :flash => { :error => "Tag phrase can not be blank." }
    else

      @event = Event.create(event_params)
      params[:event][:ruleset][:parent_id] = params[:event][:ruleset_id]
      @event_ruleset = @event.build_event_ruleset(params[:event][:event_ruleset])
      @event_ruleset.ruleset_id = @event.ruleset.id
      @event_ruleset.save

      @tag = @event.tags.create(tag_params)

      redirect_to :new_event, :flash => {:success => "Your event has been successfully created."}
    end
  end

  def update
    @tags = EventTag.all
    @event.update_attribute(:ruleset_id, params[:event][:ruleset_id])
    redirect_to manage_event_path(@event), :flash => { :success => "Ruleset applied." }
  end

  def destroy
    # @event.destroy
    # respond_to do |format|
    #   format.js
    # end
  end

  def leagues
    @leagues = Event.leagues
  end

  def join
    account = current_user.accounts.where(server_id: @event.server_id).first
    if account
      registration = account.registrations.find_or_create_by_event_id(@event.id)
      registration.update_attributes({active: true}, without_protection: true)
      redirect_to profile_path, flash: {success: "You have joined #{@event.name}, you will be assigned to a division soon"}
    else
      redirect_to new_user_account_path(current_user),
        flash: {error: "Please create an account on the #{@event.server.name} server first"}
    end
  end

  def quit
    reg = current_user.registrations.where(event_id: @event.id).first
    if reg && !reg.update_attributes({active: false, division_id: nil}, without_protection: true)
      flash[:error] = 'There was an error while deleting your registration'
    end
    redirect_to profile_path, flash: {success: "You have been removed from this event."}
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

end