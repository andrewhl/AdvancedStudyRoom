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
    if @ruleset.save
      redirect_to @ruleset, :flash => {:success => "Your ruleset has been successfully created."}
    else
      render :new
    end
  end

  def show
    @ruleset = Ruleset.find(params[:id])
    @event = Event.where("rulesetable_id = ?", @ruleset.id).first
  end

  def edit
    @ruleset = Ruleset.find(params[:id])
  end

  def update
    @ruleset = Ruleset.find(params[:id])
    if @ruleset.update_attributes(params[:ruleset])
      flash[:success] = "The ruleset has been updated."
    end
    render :edit
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