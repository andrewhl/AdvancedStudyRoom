class DivisionsController < ApplicationController
  def new
    @division = Division.new
  end

  def create
    division_params = params[:division].dup
    division_params.delete("division_ruleset")

    @tier = Tier.find(params[:tier_id])
    @event = Event.find(@tier.event.id)
    @division = @tier.divisions.create(division_params)
    @division_ruleset = @division.create_division_ruleset(params[:division][:division_ruleset])

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
