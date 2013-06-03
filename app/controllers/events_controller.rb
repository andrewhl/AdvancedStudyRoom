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

  def join_other
    @event = Event.find(params[:id])
    account = Account.find(params[:account_id])

    registration = account.registrations.find_or_create_by_event_id(@event.id)
    registration.update_attributes({active: true}, without_protection: true)
    redirect_to registration.account.user,
      flash: {success: "You have registered #{registration.account.handle} to #{@event.name}"}
  end

  def join
    @event = Event.find(params[:id])
    account = current_user.accounts.where(server_id: @event.server_id).first
    if account
      registration = account.registrations.find_or_create_by_event_id(@event.id)
      registration.update_attributes({active: true}, without_protection: true)
      redirect_to profile_path,
        flash: {success: "You have joined #{@event.name}, you will be assigned to a division soon"}
    else
      redirect_to new_user_account_path(current_user),
        flash: {error: "Please create an account on the #{@event.server.name} server first"}
    end
  end

  def quit
    reg = current_user.registrations.find(params[:registration_id])
    if reg && !reg.update_attributes({active: false, division_id: nil}, without_protection: true)
      flash[:error] = 'There was an error while deleting your registration'
    end

    if current_user.admin?
      redirect_to reg.account.user, flash: {success: "This user has been removed from this event."}
    else
      redirect_to profile_path, flash: {success: "You have been removed from this event."}
    end
  end

end