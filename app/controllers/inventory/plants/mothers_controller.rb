class Inventory::Plants::MothersController < InventoryController
  expose(:mothers) { Mother.all }
end