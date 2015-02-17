class Inventory < ActiveRecord::Base

  @@cache            = {}

  def self.total_weight
    @@cache[:total_weight] = Lot.total_weight + Bag.total_weight + Jar.total_weight + Plant.total_weight unless @@cache[:total_weight]
  end

  def self.plants
    @@cache[:plants] = {} unless @@cache[:plants]
  end

  def self.jars
    @@cache[:jars]   = {} unless @@cache[:jars]
  end

  def self.lots
    @@cache[:lots]   = {} unless @@cache[:lots]
  end

  def self.bags
    @@cache[:bags]   = {} unless @@cache[:bags]
  end

  def plants.total_weight
    @@cache[:plants][:total_weight] = Plant.total_weight unless @@cache[:plants][:total_weight]
  end

  def lots.total_weight
    @@cache[:lots][:total_weight] = Lot.total_weight unless @@cache[:lots][:total_weight]
  end

  def bags.total_weight
    @@cache[:bags][:total_weight] = Bag.total_weight unless @@cache[:bags][:total_weight]
  end

  def jars.total_weight
    @@cache[:jars][:total_weight] = Jar.total_weight unless @@cache[:jars][:total_weight]
  end
  
end