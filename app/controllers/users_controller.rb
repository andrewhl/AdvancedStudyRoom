class UsersController < ApplicationController

  def new
    @user = User.new
    @handle = Account.new
  end

  def index
  end

  def create
    @user = User.new(params[:user])

    server = Server.find_by_name(params[:account][:server_id])

    handle_params = {
      handle: params[:account][:handle],
      rank: params[:account][:rank],
      server_id: server.id
    }

    if (@user.save if @user.accounts.create(handle_params))
      redirect_to root_url, :flash => {:info => "Thank you for signing up!"}
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @accounts = @user.accounts
  end

end