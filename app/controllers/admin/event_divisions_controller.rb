class Admin::EventDivisionsController < ApplicationController

  load_and_authorize_resource :division, shallow: true, parent: false
  before_filter :add_breadcrumbs

  def edit
  end

  def update
    if @division.update_attributes(params[:division])
      redirect_to admin_event_path(@division.event)
    else
      render :edit
    end
  end

  private

    def add_breadcrumbs
      @show_breadcrumbs = true
      event = @division.event
      tier = @division.tier
      add_breadcrumb 'Events', admin_events_path
      add_breadcrumb event.name, admin_event_path(event)
      add_breadcrumb tier.name, admin_tier_path(tier)
      add_breadcrumb 'Edit Division', :edit if %W(edit update).include? params[:action]
    end

end