class TiersController < ApplicationController

  load_and_authorize_resource
  before_filter :authorize

  before_filter :event_id, :only => [:create, :destroy]
  before_filter :find_tier, :only => [:edit, :update, :destroy]

  def new
    @tier = Tier.new
  end

  def create
    tier_params = params[:tier].dup
    tier_params.delete("tier_ruleset")
    @tier = @event.tiers.build(tier_params)
    if @tier.save
      if params[:tier][:tier_ruleset]
        @tier_ruleset = @tier.build_tier_ruleset(params[:tier][:tier_ruleset])
        @tier_ruleset.parent_id = @event.event_ruleset.id
        @tier_ruleset.event_id = @event.id
        @tier_ruleset.save
      end
      redirect_to manage_event_path(@event.id), :flash => { :success => "The tier was successfully created." }
    else
      respond_to do |format|
        format.html { redirect_to manage_event_path(@event.id), :flash => { :error => @tier.errors }}
      end
    end

  end

  def destroy
    @tier.destroy

    redirect_to manage_event_path(@event.id), :flash => {:success => "The tier has been deleted."}
  end

  def index
    @tiers = Tier.all
  end

  def edit
  end

  def update
    @tier.update_attributes(params[:tier])
    redirect_to @tier.event, :flash => {:success => "The tier has been updated."}
  end

  def ruleset
    @ruleset = TierRuleset.new
    # @ruleset = @tier.build_tier_ruleset
  end

  def create_ruleset
    @tier = Tier.find(params[:tier_id])
    @ruleset = @tier.build_tier_ruleset(params[:tier_ruleset])
    redirect_to @tier.event, :flash => {:success => "Your ruleset has been created."}
  end

  private

    def event_id
      @event = Event.find(params[:event_id])
    end

    def find_tier
      @tier = Tier.find(params[:id])
    end

end