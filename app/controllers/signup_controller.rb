class SignupController < Devise::RegistrationsController

  before_filter :disallow_authenticated

  def new
    @user = User.new
    @user.accounts.build
  end

  def create
    @user = User.new(params[:user])
    account = @user.accounts.first
    account.server = Server.find_by_name('KGS')
    if @user.save
      sign_in @user
      return redirect_to profile_path, flash: {info: 'Thank you for signing up!'}
    end
    render :signup
  end

  private

    def disallow_authenticated
      redirect_to :root if current_user.present?
    end

end
