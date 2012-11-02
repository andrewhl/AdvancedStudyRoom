class EventTypesController < ApplicationController
  def new
    @event_type = EventType.new
  end

  def create
    @event_type = EventType.create(params[:event_type])
    # binding.pry
    redirect_to :new_event_type, :notice => "Your ruleset has been successfully created."
  end

  def destroy
    event_type = EventType.find(params[:id])
    event_type.destroy
    redirect_to :event_types, :notice => "The ruleset has been deleted."
  end

  def index
    @event_types = EventType.all
  end
end