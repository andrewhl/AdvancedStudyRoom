class Admin::EventTagsController < ApplicationController

  load_and_authorize_resource :event, only: [:new, :create]
  load_and_authorize_resource :event_tag, shallow: true, through_association: :tags
  before_filter :add_breadcrumbs

  def new
  end

  def create
    @event_tag = @event.tags.build(params[:event_tag])
    if @event_tag.save
      redirect_to admin_event_path(@event), flash: {success: 'Tag was created'}
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @event_tag.update_attributes(params[:event_tag])
      redirect_to admin_event_path(@event_tag.event), flash: {success: 'Tag was updated'}
    else
      render :edit
    end
  end

  def destroy
    flash[:success] = 'Tag was deleted' if @event_tag.destroy
    redirect_to admin_event_path(@event_tag.event)
  end

  private

    def add_breadcrumbs
      @show_breadcrumbs = true
      event = @event || @event_tag.event
      add_breadcrumb 'Events', admin_events_path
      add_breadcrumb event.name, admin_event_path(event)
      add_breadcrumb 'Add Tag', :add if %W(new create).include? params[:action]
      add_breadcrumb 'Edit Tag', :edit if %W(edit update).include? params[:action]
    end

end

