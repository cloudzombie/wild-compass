class Inventory < ActiveRecord::Base

  @@containers = Container.all
  @@jars       = Jar.all
  @@lots       = Lot.all
  @@bags       = Bag.all

  def total_weight
    containers.total_weight + bags.total_weight + jars.total_weight + lots.total_weight
  end

  def containers
    @@containers
  end

  def jars
    @@jars
  end

  def lots
    @@lots
  end

  def bags
    @@bags
  end
  
end