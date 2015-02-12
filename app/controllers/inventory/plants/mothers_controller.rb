class Inventory::Plants::MothersController < InventoryController
  expose(:mothers) { Plant::MotherPlant.all }
end