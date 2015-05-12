class Ability
  include CanCan::Ability
  def initialize(user)
    if user.nil?
      
    elsif user.admin?
      can :manage, :all

      can :home, Inventory
      can :download, Inventory

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

      can :perform_return, Jar
      can :destruction, Jar
      can :send_to_lab, Jar

      can :send_to_lab, Bag
      can :destruction, Bag

      can :release, Lot
      can :unrelease, Lot

      can :print_label, Bag
      can :print_label, Jar
      can :print_label, Bin

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
      can :manage, User
      can :manage, Seed
      
      can :home, Inventory
      can :download, Inventory

      can :fulfill, Order
      can :reweight, Bag

      can :scan, Bag
      can :scan, Jar

      can :recall, Bag
      can :recall, Lot

      can :quarantine, Bag
      can :quarantine, Lot

      can :perform_return, Jar
      can :destruction, Jar
      can :send_to_lab, Jar

      can :send_to_lab, Bag
      can :destruction, Bag

      can :release, Lot

      can :print_label, Bag
      can :print_label, Jar
      can :print_label, Bin
      
    else
      can :read, Brand
      can :read, Plant
      can :read, Lot
      can :read, Jar
      can :read, Bag
      can :read, Order
      can :read, Bin
      can :read, Container
      can :read, Seed

      can :home, Inventory
      can :download, Inventory

      can :fulfill, Order
      can :reweight, Bag

      can :scan, Bag
      can :scan, Jar

      can :print_label, Bag
      can :print_label, Jar
      can :print_label, Bin

      cannot :edit, :all
      cannot :update, :all
    end
  end
end