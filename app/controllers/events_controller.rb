class EventsController < ApplicationController

  def new
    @event = Event.new
    @event_types = EventType.all
  end

  def create
    @event = Event.create(params[:event])
    # binding.pry
    redirect_to :new_event, :notice => "Your event has been successfully created."
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to :events, :notice => "The event has been deleted."
  end

  def index
    @events = Event.all
  end
end