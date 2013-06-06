class UsersController < ApplicationController

  authorize_resource

  def show
    @user = User.find(current_user.id, include: {accounts: [:server, :registrations]})
  end

end