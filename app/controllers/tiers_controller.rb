class TiersController < ApplicationController
  before_filter :event_id, :only => [:create, :destroy]

  def new
    @tier = Tier.new
  end

  def create
    @tier = @event.tiers.create(params[:tier])

    if @tier.errors.any?
      notice_msg = "The tier was not created. There were errors."
    else
      notice_msg = "The tier has been successfully created."
    end

    redirect_to event_path(@event.id), :notice => notice_msg
  end

  def destroy
    tier = Tier.find(params[:id])
    tier.destroy

    redirect_to event_path(@event.id), :notice => "The tier has been deleted."
  end

  def index
    @tiers = Tier.all
  end

  private

    def event_id
      @event = Event.find(params[:event_id])
    end

end
