class Admin::EventsController < ApplicationController

  load_and_authorize_resource :event

  before_filter :add_breadcrumbs

  def index
  end

  def show
  end

  def edit
  end

  def update
    if @event.update_attributes(params[:event], without_protection: true)
      redirect_to admin_event_path(@event), flash: {success: 'Event updated' }
    else
      render :edit
    end
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

  # def new
  # end

  # def create
  #   # TODO: Add a form model to this baby!
  #   event_params = params[:event].dup
  #   event_params.delete("event_ruleset")
  #   tag_params = event_params.delete("tag")
  #   if params[:event][:tag][:phrase].empty?
  #     redirect_to :new_event, :flash => { :error => "Tag phrase can not be blank." }
  #   else
  #     @event = Event.create(event_params)
  #     params[:event][:ruleset][:parent_id] = params[:event][:ruleset_id]
  #     @event_ruleset = @event.build_event_ruleset(params[:event][:event_ruleset])
  #     @event_ruleset.ruleset_id = @event.ruleset.id
  #     @event_ruleset.save
  #     @tag = @event.tags.create(tag_params)
  #     redirect_to :new_event, :flash => {:success => "Your event has been successfully created."}
  #   end
  # end

  # def destroy
  # end

  private

    def add_breadcrumbs
      @show_breadcrumbs = true
      add_breadcrumb 'Events', admin_events_path
      add_breadcrumb @event.name, admin_event_path(@event) if @event
      add_breadcrumb 'Add', :add if %W(new create).include? params[:action]
      add_breadcrumb 'Edit', :edit if %W(edit update).include? params[:action]
    end

end
