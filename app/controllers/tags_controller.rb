class TagsController < ApplicationController
  before_filter :find_tag, :only => [:destroy, :update, :edit]

  def new
    @tag = Tag.new
    @events = Event.all
  end

  def create
    @tag = Tag.create(params[:tag])
    # binding.pry
    redirect_to :new_tag, :notice => "Your tag has been successfully created."
  end

  def destroy
    @tag.destroy
    redirect_to :tag, :notice => "The tag has been deleted."
  end

  def index
    @tags = Tag.all
  end

  def edit
  end

  def update
    @tag.update_attributes(params[:tag])
    redirect_to :tags, :notice => "The tag '#{@tag.phrase}' has been updated."
  end

  private

    def find_tag
      @tag = Tag.find(params[:id])
    end
end