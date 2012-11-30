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
    redirect_to event_path(@event.id), :flash => {:success => "Your division has been successfully created."}
  end

  def destroy
    # binding.pry
    division = Division.find(params[:id])
    event = division.tier.event
    division.destroy
    redirect_to event, :flash => {:success => "The division has been deleted."}
  end

  def index
    @divisions = Division.all
  end

  def edit
    @division = Division.find(params[:id])
  end

  def update
    @division = Division.find(params[:id])
    @division.update_attributes(params[:division])
    @event = @division.tier.event
    redirect_to @event, :flash => {:success => "Division updated."}
  end


end
