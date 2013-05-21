class EventTagsController < ApplicationController

  load_and_authorize_resource
  before_filter :authorize

  before_filter :find_event
  before_filter :find_tag, only: [:edit, :update, :destroy]
  before_filter :add_event_breadcrumb

  def index
    @tags = @event.tags
  end

  def new
    add_breadcrumb 'Add', :new
    @tag = @event.tags.build
  end

  def create
    @tag = @event.tags.build(params[:event_tag])
    if @tag.save
      redirect_to event_path(@event), flash: {success: 'Tag was created'}
    else
      render 'new'
    end
  end

  def edit
    add_breadcrumb 'Edit', :edit
  end

  def update
    flash[:success] = 'Tag was updated' if @tag.update_attributes(params[:event_tag])
    redirect_to event_path(@event)
  end

  def destroy
    flash[:success] = 'Tag was deleted' if @tag.destroy
    redirect_to event_path(@event)
  end

  private

    def add_event_breadcrumb
      @show_breadcrumbs = true
      add_breadcrumb 'Events', events_path
      add_breadcrumb @event.name, event_path(@event)
      add_breadcrumb 'Tags', event_tags_path(@event)
    end

    def find_event
      @event = Event.find(params[:event_id])
    end

    def find_tag
      @tag = @event.tags.find(params[:id])
    end
end

