class Admin::EventTagsController < ApplicationController

  load_and_authorize_resource
  before_filter :authorize

  before_filter :find_event, only: [:index, :new, :create]
  before_filter :find_event_and_tag, only: [:edit, :update, :destroy]
  before_filter :add_breadcrumbs

  def index
    @tags = @event.tags
  end

  def new
    @tag = @event.tags.build
  end

  def create
    @tag = @event.tags.build(params[:event_tag])
    if @tag.save
      redirect_to admin_event_tags_path(@event), flash: {success: 'Tag was created'}
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @tag.update_attributes(params[:event_tag])
      redirect_to admin_event_tags_path(@event), flash: {success: 'Tag was updated'}
    else
      render :edit
    end
  end

  def destroy
    flash[:success] = 'Tag was deleted' if @tag.destroy
    redirect_to admin_event_tags_path(@event)
  end

  private

    def add_breadcrumbs
      @show_breadcrumbs = true
      add_breadcrumb 'Events', admin_events_path
      add_breadcrumb @event.name, admin_event_path(@event)
      add_breadcrumb 'Tags', admin_event_tags_path(@event)
      add_breadcrumb 'Add', :add if %W(new create).include? params[:action]
      add_breadcrumb 'Edit', :edit if %W(edit update).include? params[:edit]
    end

    def find_event
      @event = Event.find(params[:event_id])
    end

    def find_event_and_tag
      @tag = EventTag.find(params[:id])
      @event = @tag.event
    end
end

