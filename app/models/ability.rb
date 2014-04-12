class Ability
  include CanCan::Ability
  include Constants::Roles

  def initialize(user)
    user ||= User.new

    can :read, Charity

    if user.has_role? CHARITY_ADMINISTRATOR
      can :manage, Charity
      can :manage, Campaign
    end
  end
end