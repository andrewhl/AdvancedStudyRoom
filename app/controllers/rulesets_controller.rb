class RulesetsController < ApplicationController
  def new
    @ruleset = Ruleset.new
    @tags = Tag.all
  end

  def create
    @ruleset = Ruleset.create(params[:ruleset])
    # binding.pry
    redirect_to :new_ruleset, :notice => "Your ruleset has been successfully created."
  end

  def destroy
    ruleset = Ruleset.find(params[:id])
    ruleset.destroy
    redirect_to :ruleset, :notice => "The ruleset has been deleted."
  end

  def index
    @ruleset = Ruleset.all
    @canon = Ruleset.canon
    @event_rulesets = Ruleset.event_rulesets
    @tier_rulesets = Ruleset.tier_rulesets
    @division_rulesets = Ruleset.division_rulesets
  end
end