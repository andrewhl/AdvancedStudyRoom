class RulesetsController < ApplicationController

  add_breadcrumb "New Ruleset", "/rulesets/new", only: [:new]
  add_breadcrumb "View Rulesets", "/rulesets/index", only: [:index]

  def new
    @ruleset = Ruleset.new
    @tags = Tag.all
  end

  def create
    @ruleset = Ruleset.new(params[:ruleset])
    if params[:ruleset][:canonical]
      @ruleset.canonical = true
    end
    @ruleset.save
    redirect_to :new_ruleset, :flash => {:success => "Your ruleset has been successfully created."}
  end

  def destroy
    ruleset = Ruleset.find(params[:id])
    ruleset.destroy
    redirect_to rulesets_path, :flash => {:success => "The ruleset has been deleted."}
  end

  def index
    @ruleset = Ruleset.all
    @canon = Ruleset.canon

    @event_rulesets = Ruleset.event_rulesets
    @tier_rulesets = Ruleset.tier_rulesets
    @division_rulesets = Ruleset.division_rulesets
    @rulesets = [@event_rulesets, @tier_rulesets, @division_rulesets]
  end
end