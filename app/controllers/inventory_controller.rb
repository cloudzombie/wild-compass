class InventoryController < ApplicationController

  expose(:inventory_lines)  { Bag.all } # + Plant.all + Jar.all + Lot.all }

  def home
  end
end
