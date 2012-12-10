class TagsController < ApplicationController
  before_filter :find_tag, :only => [:destroy, :update, :edit]

  add_breadcrumb "Manage Tags", "/index", only: [:index]
  add_breadcrumb "Edit Tag", "/edit", only: [:edit]
  add_breadcrumb "Create Tag", "/new", only: [:new]

  def new
    @tag = Tag.new
    @events = Event.all
  end

  def create
    @tag = Tag.create(params[:tag])
    @events = Event.all
    @event = Event.find(params[:tag][:event_id])

    if @tag.errors.any?
      render 'new', :flash => {:error => "Your tag has not been created."}
    else
      redirect_to :new_tag, :flash => {:success => "Your tag has been successfully created."}
    end
  end

  def destroy
    @tag.destroy
    redirect_to :tags, :flash => {:success => "The tag has been deleted."}
  end

  def index
    @tags = Tag.all
  end

  def edit
  end

  def update
    @tag.update_attributes(params[:tag])
    redirect_to :tags, :flash => {:success => "The tag '#{@tag.phrase}' has been updated."}
  end

  private

    def find_tag
      @tag = Tag.find(params[:id])
    end
end

