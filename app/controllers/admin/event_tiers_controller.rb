class Admin::EventTiersController < ApplicationController

  load_and_authorize_resource :tier, parent: false
  before_filter :add_breadcrumbs

  def edit
  end

  def update
    if @tier.update_attributes(params[:tier])
      redirect_to admin_event_path(@tier.event)
    else
      render :edit
    end
  end

  private

    def add_breadcrumbs
      @show_breadcrumbs = true
      event = @event || @tier.event
      add_breadcrumb 'Events', admin_events_path
      add_breadcrumb event.name, admin_event_path(event)
      add_breadcrumb 'Edit Tier', :edit if %W(edit update).include? params[:action]
    end

end