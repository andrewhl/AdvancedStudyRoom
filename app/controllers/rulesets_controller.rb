class RulesetsController < ApplicationController

  load_and_authorize_resource
  before_filter :authorize

  def index
    @rulesets = Ruleset.all
  end

  def new
    @ruleset = Ruleset.new
    @tags = EventTag.all
  end

  def create
    @ruleset = Ruleset.new(params[:ruleset])
    @ruleset.save
    redirect_to :new_ruleset, :flash => {:success => "Your ruleset has been successfully created."}
  end

  def edit
    @ruleset = Ruleset.find(params[:id])
  end

  def update
    ruleset = Ruleset.find(params[:id])
    ruleset.update_attributes(params[:ruleset])
    redirect_to :edit_ruleset, :flash => {:success => "The ruleset has been updated."}
  end

  def destroy
    ruleset = Ruleset.find(params[:id])
    if ruleset.destroy
      redirect_to rulesets_path, :flash => {:success => "The ruleset has been deleted."}
    else
      respond_to do |format|
        format.html { redirect_to rulesets_path, :flash => {:notice => "Notice! #{ruleset.errors[:base].to_s}"} }
      end
    end
  end

end