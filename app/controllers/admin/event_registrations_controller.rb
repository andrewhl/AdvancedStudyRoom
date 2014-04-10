class Admin::EventRegistrationsController < ApplicationController

  load_and_authorize_resource :event, only: [:index, :assign, :new, :create]
  load_and_authorize_resource :registration, through: :event, parent: false
  before_filter :add_breadcrumbs

  def index
    @registrations = @event.registrations.order('division_id ASC')
    @unassigned_players = @registrations.where(division_id: nil)
  end

  def assign
    @registrations = @event.registrations

    count = 0
    params[:registrations].each do |reg_id, div_id|
      next unless div_id.present?
      count += 1
      reg = @registrations.find(reg_id)
      division_id = div_id.to_i
      reg.update_attribute(:division_id, division_id > 0 ? division_id : nil)
      reg.update_attribute(:active, false) if division_id == -2

      if division_id == -3
        count -= 1
        if reg.matches.empty?
          count += 1
          reg.destroy
        else
          flash[:error] = 'Some registrations have games and cannot be deleted'
        end
      end
    end

    if count == 0
      flash[:warning] = 'No players were assigned'
    else
      @event.touch
      flash[:success] = "#{count} registrations #{count == 1 ? 'was' : 'were'} modified"
    end

    redirect_to admin_event_registrations_path(@event)
  end

  def deactivate
    @event.touch
    @registration.active = false
    @registration.division_id = nil
    @registration.save
    redirect_to @registration.account.user, flash: {success: "The registration has been deactivated."}
  end

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