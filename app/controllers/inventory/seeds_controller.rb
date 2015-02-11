class Inventory::SeedsController < InventoryController
  expose(:seeds) { Seed.all }
end