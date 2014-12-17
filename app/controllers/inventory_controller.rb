class InventoryController < ApplicationController

  expose(:inventory_lines)  { Plant.all + Bag.all + Jar.all + Lot.all }

  def home
  end
end
