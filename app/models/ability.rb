class Ability
  include CanCan::Ability
  def initialize(user)
    if user.admin?
      can :manage, :all
    elsif user.manager?
      can :manage, Plant
      can :manage, Lot
      can :manage, Jar
      can :manage, Bag
      can :manage, Order
    else
      can :read, Plant
      can :read, Lot
      can :read, Jar
      can :read, Bag
      can :read, Order
    end
  end
end
