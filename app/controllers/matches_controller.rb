class MatchesController < ApplicationController

  load_and_authorize_resource
  before_filter :authorize

  before_filter :find_registration, only: [:download]

  def index
    @matches = Match.where("black_player_id = ? OR white_player_id = ?", params[:registration_id], params[:registration_id])
    @registration = Registration.find(params[:registration_id])
  end

  def download
    registration = Registration.find(params[:registration_id])
    server = registration.server
    sgf_importer = ASR::SGFImporter.new(server: server, ignore_case: true)
    matches = sgf_importer.import_matches(handle: registration.handle)
    matches.each(&:save)
    redirect_to registration_matches_path(registration), flash: {success: "Your matches have been downloaded."}
  end

  def validate
    match = Match.find(params[:id])
    division = match.division
    validator = ASR::MatchValidator.new(division.rules)
    match.update_attribute(:valid_match, validator.valid?(match))
    match.update_attribute(:validation_errors, validator.errors.join(","))

    redirect_to :back, flash: {success: "Yay"}
  end

  def check_tags
    match = Match.find(params[:id])
    tag_checker = ASR::TagChecker.new(match.event)
    match.update_attribute(:tagged, tag_checker.tagged?(match))

    redirect_to :back, flash: {success: "Yay"}
  end

  private
    def find_registration
      @registration = Registration.find(params[:registration_id])
    end
end
