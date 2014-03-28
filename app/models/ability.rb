class Ability
  include CanCan::Ability
  include Constants::Roles

  def initialize(user)
    user ||= User.new

    can :read, Charity

    if user.has_role? CHARITY_REGISTRAR
      can :manage, Charity
    end
  end
end