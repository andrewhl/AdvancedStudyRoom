class UsersController < ApplicationController
  extend Utilities
  layout "user"

  def new
    @user = User.new
    @account = Account.new
  end

  def index
    redirect_to :root
  end

  def create

    @user = User.new(params[:user])

    server = Server.find_by_name(params[:account][:server_id])

    handle_params = {
      handle: params[:account][:handle],
      rank: UsersController.rank_convert(params[:account][:rank]),
      server_id: server.id
    }

    if handle_params[:handle].empty?
      @user.errors[:base] << "Handle cannot be blank."
    elsif handle_params[:rank].nil?
      @user.errors[:base] << "Rank cannot be blank."
    elsif not @user.handle_is_unique?(handle_params[:handle], server.id)
      @user.errors[:base] << "That handle has already been taken for this server."
    end

    # if not handle_params[:handle].empty?
    #   if Account.find_by_handle(handle_params[:handle])
    #     @user.errors[:base] << "That handle has already been taken."
    #   end
    # end

    unless @user.errors.any?
      @user.save
      @account = @user.accounts.create(handle_params)
      session[:user_id] = @user.id
      redirect_to root_url, :flash => {:info => "Thank you for signing up!"}
    else
      @account = Account.new
      render "new", :account => @account
    end
  end

  def show
    @user = User.find(params[:id])
    @accounts = @user.accounts
    add_breadcrumb "#{@user.username.to_s}", "users/:id"
  end

end