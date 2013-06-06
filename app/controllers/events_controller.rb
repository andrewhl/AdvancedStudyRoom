class EventsController < ApplicationController

  load_and_authorize_resource
  before_filter :authorize, except: [:leagues, :show]

  def show
    @event = Event.find(
      params[:id],
      include: [:tags, {tiers: [:registrations, :divisions]}])
    @ruleset = @event.ruleset
  end

  def leagues
    @leagues = Event.leagues
  end

  def join
    @event = Event.find(params[:id])
    account = current_user.accounts.where(server_id: @event.server_id).first
    if account
      registration = account.registrations.find_or_create_by_event_id(@event.id)
      registration.update_attributes({active: true, division_id: nil}, without_protection: true)
      redirect_to profile_path,
        flash: {success: "You have joined #{@event.name}, you will be assigned to a division soon"}
    else
      redirect_to new_user_account_path(current_user),
        flash: {error: "Please create an account on the #{@event.server.name} server first"}
    end
  end

  def quit
    reg = current_user.registrations.where(event_id: params[:id]).first
    if reg && !reg.update_attributes({active: false}, without_protection: true)
      flash[:error] = 'There was an error while deleting your registration'
    end

    redirect_to profile_path, flash: {success: "You have been removed from the event."}
  end

end