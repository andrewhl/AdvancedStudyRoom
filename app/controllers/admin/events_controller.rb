class Admin::EventsController < ApplicationController

  authorize_resource :event
  before_filter :add_breadcrumbs

  def index
    @events = Event.order('starts_at DESC')
  end

  def show
    @event = Event.find(params[:id])
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

    def add_breadcrumbs
      @show_breadcrumbs = true
      add_breadcrumb 'Events', admin_events_path
      add_breadcrumb @event.name, admin_event_path(@event) if @event
      add_breadcrumb 'Add', :add if %W(new create).include? params[:action]
      add_breadcrumb 'Edit', :edit if %W(edit update).include? params[:action]
    end

end
