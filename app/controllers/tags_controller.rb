class TagsController < ApplicationController
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
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to :tag, :notice => "The tag has been deleted."
  end

  def index
    @tags = Tag.all
  end
end