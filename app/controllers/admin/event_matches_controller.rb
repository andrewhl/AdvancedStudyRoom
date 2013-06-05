class Admin::EventMatchesController < ApplicationController

  load_and_authorize_resource :event, only: [:index]
  load_and_authorize_resource :match, parent: false, through: :event
  before_filter :set_pagination
  before_filter :add_breadcrumbs

  def index
    @matches = @event.matches.
                  order(matches_order).
                  paginate(
                    include: {division: nil, white_player: [:account], black_player: [:account], tags: nil},
                    page: @pag[:page], per_page: @pag[:per_page])
  end

  private

    def set_pagination
      @pag = {
        page: params[:page] || 1,
        per_page: params[:per_page] || 25,
        order: params[:order] || 'completed_at',
        order_dir: params[:order_dir] || 'desc' }
    end

    def matches_order
      dir = @pag[:order].to_s =~ /desc/i ? 'desc' : 'asc'
      order_map = {
        date: 'completed_at',
        black: 'black_player_name',
        white: 'white_player_name',
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