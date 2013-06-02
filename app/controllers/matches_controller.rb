class MatchesController < ApplicationController

  load_and_authorize_resource
  before_filter :authorize

  before_filter :find_registration, only: [:download]

  def index
    @matches = Match.all
  end

  def validate
    match = Match.find(params[:id])
    division = match.division
    validator = ASR::MatchValidator.new(division.rules)
    match.update_attribute(:valid_match, validator.valid?(match))
    match.update_attribute(:validation_errors, validator.errors.join(","))

    redirect_to :back, flash: {success: "Match validated"}
  end

  def check_tags
    match = Match.find(params[:id])
    event = match.event
    tag_checker = ASR::TagChecker.new(event.tags)
    match.update_attribute(:tagged, tag_checker.tagged?(match.tags, event.ruleset.node_limit))

    redirect_to :back, flash: {success: "Tags checked"}
  end

  def matches
    @event = Event.find(params[:id])
  end

  def download
    server = Server.where(name: 'KGS').first
    importer = ASR::SGFImporter.new(server: server, ignore_case: true)

    matches = importer.import_matches(handle: @registration.account.handle)
    matches.each(&:save)

    redirect_to :back, flash: {success: "Matches downloaded"}
  end

  private
    def find_registration
      @registration = Registration.find(params[:registration_id])
    end
end
