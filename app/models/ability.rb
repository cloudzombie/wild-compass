class Ability
  include CanCan::Ability
  def initialize(user)
    if user.admin?
      can :manage, :all

      can :send_to_lab, Bag
      can :home, 'Inventory'
      can :home, 'Dashboard'
      can :download, 'Inventory'
    elsif user.manager?
      can :manage, Brand
      can :manage, Plant
      can :manage, Lot
      can :manage, Jar
      can :manage, Bag
      can :manage, Order
      can :manage, User
      
      can :send_to_lab, Bag
      can :home, 'Inventory'
      can :home, 'Dashboard'
      can :download, 'Inventory'
    else
      can :read, Brand
      can :read, Plant
      can :read, Lot
      can :read, Jar
      can :read, Bag
      can :read, Order

      can :home, 'Inventory'
      can :home, 'Dashboard'
      can :download, 'Inventory'
    end
  end
end
