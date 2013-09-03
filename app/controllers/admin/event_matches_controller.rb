class Admin::EventMatchesController < ApplicationController

  before_filter :load_event, only: [:index, :new, :create]
  before_filter :load_match, only: [:show, :edit, :update, :auto_tag]

  before_filter :set_pagination, only: [:index]
  before_filter :add_breadcrumbs, except: [:validate_and_tag, :create]

  def index
    query = params[:query]
    @matches = @event.matches.order(matches_order).
        paginate(
          include: {division: nil, white_player: [:account], black_player: [:account], tags: nil},
          page: @pag[:page], per_page: @pag[:per_page])
    @matches = @matches.where('LOWER(black_player_name) LIKE LOWER(?) OR LOWER(white_player_name) LIKE LOWER(?)', query, query) if query.present?
  end

  def show
  end

  def new
    @match = Match.new
  end

  def create
    file = params[:match][:filename]

    sgf_data = ASR::SGFData.new(file_path: file.path)
    match_builder = ASR::SGFMatchBuilder.new(server_id: @event.server_id, event_id: @event.id)

    begin
      match = match_builder.build_match(sgf_data)
      # puts "Match details: " + match.inspect
      # binding.pry
      raise "Match could not be saved" unless match && match.save
      return redirect_to admin_match_path(match)
    rescue => e
      redirect_to admin_event_matches_path, flash: {error: e.message}
    end

  end

  def validate_and_tag
    match = Match.find(params[:id], include: {division: nil, tags: nil, event: [:tags, :ruleset]})
    authorize! :validate_and_tag, match

    match.validate_and_tag

    msg = ['Match is']
    msg << 'NOT' unless match.valid_match
    msg << 'valid'
    msg << (match.tagged == match.valid_match ? 'and' : 'but is')
    msg << 'NOT' unless match.tagged
    msg << 'properly tagged'

    redirect_url = admin_event_matches_path(match.event)
    redirect_url = :back if params[:redirect] == 'back'
    redirect_to redirect_url, flash: {success: msg.join(' ')}
  end

  def auto_tag
    phrase = @match.try(:event).try(:tags).try(:first).try(:phrase)
    if phrase
      @match.tags.create(phrase: phrase, node: 1, handle: @match.black_player_name)
      @match.validate_and_tag
    else
      flash[:error] = "Event has no tags."
    end
    redirect_to admin_match_path(@match)
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