class TierRulesetsController < ApplicationController

  def edit
    @tier_ruleset = TierRuleset.find(params[:tier_id])
  end

  def update
    @tier_ruleset = TierRuleset.find(params[:tier_id])
    @tier_ruleset.update_attributes(:tier_ruleset)
  end

end