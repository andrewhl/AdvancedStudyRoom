class EventsController < ApplicationController

  def new
    @event = Event.new
    @rulesets = Ruleset.canon
    @servers = Server.all
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

  def show
    @event = Event.find(params[:id])
    @tier = Tier.new
    @tiers = @event.tiers
    @division = Division.new
    @divisions = @tier.divisions
  end
end