class Admin::EventMatchesController < ApplicationController

  before_filter :load_event, only: [:index]
  before_filter :load_match, only: [:show, :edit, :update]

  before_filter :set_pagination, only: [:index]
  before_filter :add_breadcrumbs, except: [:validate_and_tag]

  def index
    @matches = @event.matches.
                  order(matches_order).
                  paginate(
                    include: {division: nil, white_player: [:account], black_player: [:account], tags: nil},
                    page: @pag[:page], per_page: @pag[:per_page])
  end

  def show
  end

  def validate_and_tag
    match = Match.find(params[:id], include: {division: nil, tags: nil, event: [:tags, :ruleset]})
    event = match.event
    authorize! :validate_and_tag, match

    validator = ASR::MatchValidator.new(match.division.rules)
    match.update_attribute(:valid_match, validator.valid?(match))
    match.update_attribute(:validation_errors, validator.errors.join(","))

    tag_checker = ASR::TagChecker.new(event.tags)
    match.update_attribute(:tagged, tag_checker.tagged?(match.tags, event.ruleset.node_limit))

    msg = ['Match is']
    msg << 'NOT' unless match.valid_match
    msg << 'valid'
    msg << (match.tagged == match.valid_match ? 'and' : 'but is')
    msg << 'NOT' unless match.tagged
    msg << 'properly tagged'

    redirect_url = admin_event_matches_path(event)
    redirect_url = :back if params[:redirect] == 'back'
    redirect_to redirect_url, flash: {success: msg.join(' ')}
  end

  private

    def load_event
      @event = Event.find(params[:event_id])
      authorize! :manage, @event
    end

    def load_match
      @match = Match.find(params[:id])
      authorize! :show, @match
    end

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
      add_breadcrumb @match.name, admin_match_path(@match) if %w(show).include? params[:action]
    end

end