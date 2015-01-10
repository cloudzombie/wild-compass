class Ability
  include CanCan::Ability
  def initialize(user)
    if user.admin?
      can :manage, :all
      can :send_to_lab, Bag
    elsif user.manager?
      can :manage, Plant
      can :manage, Lot
      can :manage, Jar
      can :manage, Bag
      can :manage, Order
      can :send_to_lab, Bag
    else
      can :manage, Plant
      can :manage, Lot
      can :manage, Jar
      can :manage, Bag
      can :manage, Order
      can :send_to_lab, Bag
    end
  end
end
