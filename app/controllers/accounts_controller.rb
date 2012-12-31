class AccountsController < ApplicationController
  before_filter :authorize, :only => [:new]

  add_breadcrumb "Accounts", only: [:new]

  def new
    @handle = Account.new

  end

  def create
    server = Server.find_by_name(params[:account][:server_id])

    handle_params = {
      handle: params[:account][:handle].downcase,
      display_name: params[:account][:handle],
      rank: params[:account][:rank],
      server_id: server.id
    }
    current_user.accounts.create handle_params

    redirect_to root_path, :flash => {:success => "Success"}
  end

  def destroy

  end


end