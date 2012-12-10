class DivisionRulesetsController < ApplicationController

  def edit
    @division_ruleset = TierRuleset.find(params[:id])
    @division = @division_ruleset.division
  end

  def update
    @division_ruleset = TierRuleset.find(params[:id])
    @division_ruleset.update_attributes(params[:division_ruleset])
    @division = @division_ruleset.division
    @event = @division.event
    redirect_to @event, :flash => {:success => "Ruleset updated."}
  end

end