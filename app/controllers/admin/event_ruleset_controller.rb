class Admin::EventRulesetController < ApplicationController

  load_and_authorize_resource :event
  load_and_authorize_resource :ruleset, through: :event, singleton: true
  before_filter :add_breadcrumbs

  def edit
  end

  def update
    if @ruleset.update_attributes(params[:ruleset])
      redirect_to admin_event_path(@event),
        flash: {success: 'The ruleset has been updated'}
    else
      render :edit
    end
  end

  private

    def add_breadcrumbs
      @show_breadcrumbs = true
      add_breadcrumb 'Events', admin_events_path
      add_breadcrumb @event.name, admin_event_path(@event)
      add_breadcrumb 'Edit Ruleset', :edit if %W(edit update).include? params[:action]
    end

end