class Admin::EventsController < ApplicationController

  load_and_authorize_resource
  before_filter :authorize

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @tier = Tier.new
    @tiers = @event.tiers
    @division = Division.new
    @divisions = @tier.divisions
    @rulesets = Ruleset.all
  end

  def new
    @event = Event.new
    # @rulesets = Ruleset.all
    # @servers = Server.all
    # @ruleset = @event.build_ruleset
    # @tag = EventTag.new
    # @tags = EventTag.select { |tag| !tag.event.nil? }
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

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event], without_protection: true)
      redirect_to admin_event_path(@event), flash: {success: 'Event updated' }
    else
      render :edit
    end
  end

  def destroy
  end

  def download_matches
    return unless Rails.env.development?
    event = Event.find(params[:id], include: [:registrations])
    sgf_importer = ASR::SGFImporter.new(server: event.server, ignore_case: true)
    event.registrations.each do |reg|
      matches = sgf_importer.import_matches(handle: reg.handle)
      matches.each(&:save)
    end
    redirect_to matches_event_path(event), flash: {success: 'Event matches were downloaded'}
  end

  private

    def find_event
      @event = Event.find(params[:id])
    end

end
