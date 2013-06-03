class Admin::EventRulesetController < ApplicationController

  # load_and_authorize_resource
  # authorize_resource
  before_filter :authorize
  before_filter :find_event_and_ruleset
  before_filter :add_breadcrumbs

  def show
  end

  def edit
    add_breadcrumb 'Edit'
  end

  def update
    if @ruleset.update_attributes(params[:ruleset])
      redirect_to action: :show, flash: {success: 'The ruleset has been updated'}
    else
      render :edit
    end
  end

  private

    def find_event_and_ruleset
      @event = Event.find(params[:event_id], include: :ruleset)
      @ruleset = @event.ruleset
    end

    def add_breadcrumbs
      @show_breadcrumbs = true
      add_breadcrumb 'Events', admin_events_path
      add_breadcrumb @event.name, admin_event_path(@event)
      add_breadcrumb 'Ruleset', admin_event_ruleset_path(@event)
    end

end