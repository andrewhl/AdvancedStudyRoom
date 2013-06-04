class Admin::DivisionRulesetsController < ApplicationController

  load_and_authorize_resource :division
  load_and_authorize_resource :tier, through: :division, singleton: true
  load_and_authorize_resource :ruleset, through: :division, singleton: true
  before_filter :add_breadcrumbs

  def edit
  end

  def update
    if @ruleset.update_attributes(params[:ruleset])
      redirect_to admin_event_path(@tier.event),
        flash: {success: 'The ruleset has been updated'}
    else
      render :edit
    end
  end

  private

    def add_breadcrumbs
      @show_breadcrumbs = true
      add_breadcrumb 'Events', admin_events_path
      add_breadcrumb @tier.event.name, admin_event_path(@tier.event)
      add_breadcrumb @tier.name, admin_tier_path(@tier)
      add_breadcrumb @division.name, admin_division_path(@division)
      add_breadcrumb 'Edit Ruleset', :edit if %W(edit update).include? params[:action]
    end
end
