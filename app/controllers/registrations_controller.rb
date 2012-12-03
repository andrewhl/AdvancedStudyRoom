class RegistrationsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @registration = Registration.new
    @accounts = current_user.accounts
  end

  def create
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.build
    @registration.account_id = params[:registration][:registration][:account_id]
    @registration.save
    redirect_to :leagues, :flash => {:success => "Event joined."}
  end

  def destroy
    # ruleset = Ruleset.find(params[:id])
    # ruleset.destroy
    # redirect_to rulesets_path, :flash => {:success => "The ruleset has been deleted."}
  end

  def index
    # @ruleset = Ruleset.all
    # @canon = Ruleset.canon
    # @event_rulesets = Ruleset.event_rulesets
    # @tier_rulesets = Ruleset.tier_rulesets
    # @division_rulesets = Ruleset.division_rulesets
  end
end