module AccountsHelper

  def available_user_servers(account = nil)
    user = account.try(:user)
    if user.nil?
      Server.all
    else
      user_server_ids = user.servers.collect { |s| s.id }
      user_server_ids.reject! { |i| i == account.server_id} if account.present?
      Server.all.reject { |s| user_server_ids.include?(s.id) }
    end
  end

end
