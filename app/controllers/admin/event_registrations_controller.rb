class Admin::EventRegistrationsController < ApplicationController

  load_and_authorize_resource :event, only: [:index, :assign, :new, :create]
  load_and_authorize_resource :registration, through: :event, parent: false
  before_filter :add_breadcrumbs

  def index
    @registrations = @event.registrations.active.order("division_id ASC")
    @unassigned_players = @registrations.where(division_id: nil)
  end

  def assign
    @registrations = @event.registrations.active
    count = 0
    params[:registrations].each do |reg_id, div_id|
      next unless div_id.present?
      count += 1
      reg = @registrations.find(reg_id)
      reg.update_attribute(:division_id, div_id.to_i > 0 ? div_id : nil)
    end

    if count == 0
      flash[:warning] = 'No players were assigned'
    else
      @event.touch
      flash[:success] = "#{count} players #{count == 1 ? 'was' : 'were'} assigned to a different division"
    end

    redirect_to admin_event_registrations_path(@event)
  end

  def deactivate
    @event.touch
    @registration.update_attribute(active: false)
    redirect_to @registration.account.user, flash: {success: "The registration has been deactivated."}
  end

  # def new
  #   @registration = Registration.new
  #   @accounts = current_user.accounts
  # end

  # def create
  #   @registration = @event.registrations.build
  #   @registration.account_id = params[:registration][:registration][:account_id]
  #   account = Account.find(@registration.account_id)
  #   @registration.handle = account.handle.downcase # all registrations will be saved as lowercase
  #   @registration.display_name = account.display_name # the display name is the handle, but as the user entered it
  #   @registration.save
  #   redirect_to :leagues, :flash => {:success => "Event joined."}
  # end

  # def destroy
  #   registration = Registration.find(params[:id])
  #   registration.destroy
  #   redirect_to :leagues, :flash => {:info => "You have been removed from the event."}
  # end

  def matches
  end

  private

    def add_breadcrumbs
      @show_breadcrumbs = true
      event = @event || @registration.event
      add_breadcrumb 'Events', admin_events_path
      add_breadcrumb event.name, admin_event_path(event)
      add_breadcrumb 'Assign Players', admin_event_registrations_path(event)
    end
end