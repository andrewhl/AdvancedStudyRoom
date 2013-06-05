class Admin::EventMatchesController < ApplicationController

  load_and_authorize_resource :event, only: [:index]
  load_and_authorize_resource :match, parent: false, through: :event, except: [:validate]
  before_filter :set_pagination, only: [:index]
  before_filter :add_breadcrumbs, except: [:validate, :check_tags]

  def index
    @matches = @event.matches.
                  order(matches_order).
                  paginate(
                    include: {division: nil, white_player: [:account], black_player: [:account], tags: nil},
                    page: @pag[:page], per_page: @pag[:per_page])
  end

  def show
  end

  def validate
    match = Match.find(params[:id], include: :division)
    validator = ASR::MatchValidator.new(match.division.rules)
    match.update_attribute(:valid_match, validator.valid?(match))
    match.update_attribute(:validation_errors, validator.errors.join(","))
    msg = match.valid_match ? 'Match was validated and is valid' :
                               'Match was validated and is NOT valid'

    authorize! :validate, match
    redirect_to admin_event_matches_path(match.event), flash: {success: msg}
  end

  def check_tags
    match = Match.find(params[:id], include: {tags: nil, event: [:tags, :ruleset]})
    event = match.event
    tag_checker = ASR::TagChecker.new(event.tags)
    match.update_attribute(:tagged, tag_checker.tagged?(match.tags, event.ruleset.node_limit))
    redirect_to :back, flash: {success: 'Tags checked'}
  end

  private

    def set_pagination
      @pag = {
        page: params[:page] || 1,
        per_page: params[:per_page] || 25,
        order: params[:order] || 'date',
        order_dir: params[:order_dir] || 'desc' }
    end

    def matches_order
      dir = @pag[:order_dir].to_s =~ /desc/i ? 'desc' : 'asc'
      order_map = {
        date: 'completed_at',
        black: 'LOWER(black_player_name)',
        white: 'LOWER(white_player_name)',
        win_info: 'win_info' }
      if col = order_map[@pag[:order].to_sym]
        "#{col} #{dir}"
      else
        "completed_at desc"
      end
    end

    def add_breadcrumbs
      @show_breadcrumbs = true
      event = @event || @match.event
      add_breadcrumb 'Events', admin_events_path
      add_breadcrumb event.name, admin_event_path(event)
      add_breadcrumb 'Matches', admin_event_matches_path(event)
    end

end