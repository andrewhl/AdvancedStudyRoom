class TiersController < ApplicationController
  before_filter :event_id, :only => [:create, :destroy]
  before_filter :find_tier, :only => [:edit, :update, :destroy]

  def new
    @tier = Tier.new
  end

  def create
    tier_params = params[:tier].dup
    tier_params.delete("tier_ruleset")
    @tier = @event.tiers.build(tier_params)
    @tier.save

    if params[:tier][:tier_ruleset]
      @tier_ruleset = @tier.create_tier_ruleset(params[:tier][:tier_ruleset])
    end

    if @tier.errors.any?
      notice_msg = "The tier was not created. There were errors."
    else
      notice_msg = "The tier has been successfully created."
    end

    redirect_to manage_event_path(@event.id), :notice => notice_msg
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
    redirect_to @tier.event, :flash => {:success => "Your override ruleset has been created."}
  end

  private

    def event_id
      @event = Event.find(params[:event_id])
    end

    def find_tier
      @tier = Tier.find(params[:id])
    end

end