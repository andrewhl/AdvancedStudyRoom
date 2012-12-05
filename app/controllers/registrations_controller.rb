class RegistrationsController < ApplicationController
  before_filter :find_event, :only => [:new, :create, :update, :destroy, :index]

  def new
    @registration = Registration.new
    @accounts = current_user.accounts
  end

  def create
    @registration = @event.registrations.build
    @registration.account_id = params[:registration][:registration][:account_id]
    account = Account.find(@registration.account_id)
    @registration.handle = account.handle
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
    puts "test"
    @divisions = @event.tiers.collect { |t| t.divisions }.flatten

    # @event_users = @event.accounts
    @unassigned_players = @registrations.select { |e| e.division.nil? }
  end

  def update
    @registrations = Registration.find(params[:registration_id])
    div_id = params[:division_id]
    @registrations.each do |reg|
      reg.division_id = div_id
      reg.save
    end
    redirect_to :event_registrations
    # @divisions = @event.tiers.collect { |t| t.divisions }
  end



  def find_event
    @event = Event.find(params[:event_id])
  end
end