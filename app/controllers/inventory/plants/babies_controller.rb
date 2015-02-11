class Inventory::Plants::BabiesController < InventoryController
  expose(:babies) { Baby.all }
end