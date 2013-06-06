class Admin::MatchTagsController < ApplicationController

  load_and_authorize_resource :match, only: [:new, :create]
  load_and_authorize_resource :match_tag, shallow: true, through_association: :tags
  before_filter :add_breadcrumbs

  def new
  end

  def create
    @match_tag = @match.tags.build(params[:match_tag])
    if @match_tag.save
      redirect_to admin_match_path(@match), flash: {success: 'Tag was created'}
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @match_tag.update_attributes(params[:match_tag])
      redirect_to admin_match_path(@match_tag.match), flash: {success: 'Tag was updated'}
    else
      render :edit
    end
  end

  def destroy
    flash[:success] = 'Tag was deleted' if @match_tag.destroy
    redirect_to admin_match_path(@match_tag.match)
  end

  private

    def add_breadcrumbs
      @show_breadcrumbs = true
      match = @match || @match_tag.match
      event = match.event
      add_breadcrumb 'Events', admin_events_path
      add_breadcrumb event.name, admin_event_path(event)
      add_breadcrumb 'Matches', admin_event_matches_path(event)
      add_breadcrumb match.name, admin_match_path(match)
      add_breadcrumb 'Add Tag', :new if %W(new create).include? params[:action]
      add_breadcrumb 'Edit Tag', :edit if %W(edit update).include? params[:action]
    end


end