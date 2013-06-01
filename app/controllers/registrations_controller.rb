class RegistrationsController < ApplicationController

  load_and_authorize_resource
  before_filter :authorize

  before_filter :find_event, :only => [:new, :create, :update, :destroy, :index, :remove]

  def new
    @registration = Registration.new
    @accounts = current_user.accounts
  end

  def create
    @registration = @event.registrations.build
    @registration.account_id = params[:registration][:registration][:account_id]
    account = Account.find(@registration.account_id)
    @registration.handle = account.handle.downcase # all registrations will be saved as lowercase
    @registration.display_name = account.display_name # the display name is the handle, but as the user entered it
    @registration.save
    redirect_to :leagues, :flash => {:success => "Event joined."}
  end

  def destroy
    registration = Registration.find(params[:id])
    registration.destroy
    redirect_to :leagues, :flash => {:info => "You have been removed from the event."}
  end

  def index
    @registrations = @event.registrations.active
    @registrations = @registrations.sort { |a,b| a.handle <=> b.handle }
    puts "test"
    @divisions = @event.tiers.collect { |t| t.divisions }.flatten

    # @event_users = @event.accounts
    @unassigned_players = @registrations.select { |e| e.division.nil? }
    add_breadcrumb "Events", :events
    add_breadcrumb "#{@event.name}", @event
    add_breadcrumb "Assign Players", "/index"
  end

  def update
    @registrations = @event.registrations
    @divisions = @event.tiers.collect { |t| t.divisions }.flatten
    @unassigned_players = @registrations.select { |e| e.division.nil? }
    if params[:registration_id].nil?
      flash[:error] = "You did not select a player."
      render "index"
      flash.discard
    else
      @registrations = Registration.find(params[:registration_id])
      div_id = params[:division_id]
      @registrations.each do |reg|
        reg.division_id = div_id
        reg.save
      end
      redirect_to :event_registrations
    end

    # @divisions = @event.tiers.collect { |t| t.divisions }
  end

  def matches
    @registration = Registration.find(params[:id])
  end

  def remove
    @registration = Registration.find(params[:id])
    @registration.division_id = nil
    @registration.save

    redirect_to :event_registrations
  end


  def find_event
    @event = Event.find(params[:event_id])
  end
end