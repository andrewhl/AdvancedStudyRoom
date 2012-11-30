class TierRulesetsController < ApplicationController

  def edit
    @tier_ruleset = TierRuleset.find(params[:id])
    @tier = @tier_ruleset.tier
  end

  def update
    @tier_ruleset = TierRuleset.find(params[:id])
    @tier_ruleset.update_attributes(params[:tier_ruleset])
    @tier = @tier_ruleset.tier
    @event = @tier.event
    redirect_to @event, :flash => {:success => "Ruleset updated."}
  end

end