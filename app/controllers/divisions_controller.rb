class DivisionsController < ApplicationController
  def new
    @division = Division.new
  end

  def create
    @tier = Tier.find(params[:tier_id])
    @event = Event.find(@tier.event.id)
    @division = @tier.divisions.create(params[:division])
    # binding.pry
    redirect_to event_path(@event.id), :notice => "Your division has been successfully created."
  end

  def destroy
    division = Division.find(params[:id])
    division.destroy
    redirect_to :divisions, :notice => "The division has been deleted."
  end

  def index
    @divisions = Division.all
  end

end
