module UsersHelper

  def link_to_results(name, registration)
    results_path = event_results_path(registration.event, division_id: registration.division_id)
    link_to(name, results_path)
  end

  def can_add_account?(user)
    user.accounts.count < Server.count
  end

  def can_join_events?(user)
    user.registrations.count < Event.count
  end

end