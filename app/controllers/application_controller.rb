class ApplicationController < ActionController::Base

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |ex|
    flash[:error] = "Access denied!"
    flash[:error] << "#{ex.subject} || #{ex.action}" if Rails.env.development?
    render 'pages/home', status: :forbidden
  end

  def initialize
    @title = []
    @body_class = []
    super
  end

  private

    helper_method :current_user

    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end

    def authorize
      redirect_to login_url, alert: "Not authorized" if current_user.nil?
    end
end