class DivisionsController < ApplicationController

  load_and_authorize_resource
  before_filter :authorize

  def new
    @division = Division.new
  end

  def create
    division_params = params[:division].dup
    division_params.delete("division_ruleset")

    @tier = Tier.find(params[:tier_id])
    @event = Event.find(@tier.event.id)
    @division = @tier.divisions.build(division_params)
    @division.event_id = @event.id
    @division.name = "#{@tier.name} #{@division.index}"

    if @division.save
      @division_ruleset = @division.build_division_ruleset(params[:division][:division_ruleset])
      @division_ruleset.parent_id = @tier.tier_ruleset.id
      @division_ruleset.update_attributes(:event_id => @event.id, :tier_id => @tier.id)
      redirect_to manage_event_path(@event.id), :flash => {:success => "Your division has been successfully created."}
    else
      respond_to do |format|
        format.html { redirect_to manage_event_path(@event.id), :flash => { :error => @division.errors }}
      end
    end

  end

  def destroy
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