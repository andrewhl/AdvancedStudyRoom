class RegistrationsController < ApplicationController
  before_filter :find_event, :only => [:new, :create, :destroy, :index]

  def new
    @registration = Registration.new
    @accounts = current_user.accounts
  end

  def create
    @registration = @event.registrations.build
    @registration.account_id = params[:registration][:registration][:account_id]
    @registration.save
    redirect_to :leagues, :flash => {:success => "Event joined."}
  end

  def destroy
    registration = Registration.find(params[:id])
    registration.destroy
    redirect_to :leagues, :flash => {:info => "You have been removed from the event."}
  end

  def index
    @registrations = @event.registrations
  end

  def find_event
    @event = Event.find(params[:event_id])
  end
end