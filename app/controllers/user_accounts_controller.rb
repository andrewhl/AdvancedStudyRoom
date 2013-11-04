class UserAccountsController < ApplicationController

  # load_and_authorize_resource :user
  # load_and_authorize_resource :account, shallow: true, through_association: :user, parent: false

  def new
    @account = current_user.accounts.build
  end

  def create
    @account = current_user.accounts.first || current_user.accounts.build(params[:account])
    if @account.save
      redirect_to :back, flash: {success: 'The account was created'}
    else
      render 'new'
    end
  end



end