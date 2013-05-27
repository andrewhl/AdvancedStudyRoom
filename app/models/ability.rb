class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new

    alias_action :create, :read, :update, :destroy, to: :crud

    if @user.admin?
      define_admin
    elsif @user.id.to_i > 0
      define_member
      define_visitor
    else
      define_visitor
    end
  end

  private

    def define_admin
      can :manage, :all
    end

    def define_member
      can :profile, User, id: @user.id
      can [:join, :quit, :show], Event
      can [:index], Post
    end

    def define_visitor
      can [:index], Post
      can [:signup, :process_signup], User
      can [:leagues, :show], Event
    end
end
