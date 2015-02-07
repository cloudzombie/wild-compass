class Ability
  include CanCan::Ability
  def initialize(user)
    if user.nil?
      
    elsif user.admin?
      can :manage, :all

      can :send_to_lab, Bag
      can :home, 'Inventory'
      can :home, 'Dashboard'
      can :download, 'Inventory'

      can :fulfill, Order
      can :reweight, Bag
      
      can :scan, Bag
      can :scan, Jar

      can :quarantine, Bag
      can :quarantine, Lot

      can :recall, Bag
      can :recall, Lot

      can :unquarantine, Bag
      can :unquarantine, Lot

      can :unrecall, Bag
      can :unrecall, Lot

    elsif user.manager?
      can :manage, Brand
      can :manage, Plant
      can :manage, Lot
      can :manage, Jar
      can :manage, Bag
      can :manage, Order
      can :manage, User
      can :manage, Bin
      can :manage, Container
      
      can :send_to_lab, Bag
      can :home, 'Inventory'
      can :home, 'Dashboard'
      can :download, 'Inventory'

      can :fulfill, Order
      can :reweight, Bag

      can :scan, Bag
      can :scan, Jar

      can :recall, Bag
      can :recall, Lot

      can :quarantine, Bag
      can :quarantine, Lot
      
    else
      can :read, Brand
      can :read, Plant
      can :read, Lot
      can :read, Jar
      can :read, Bag
      can :read, Order
      can :read, Bin
      can :read, Container

      can :home, 'Inventory'
      can :home, 'Dashboard'
      can :download, 'Inventory'

      can :fulfill, Order
      can :reweight, Bag

      can :scan, Bag
      can :scan, Jar
    end
  end
end
