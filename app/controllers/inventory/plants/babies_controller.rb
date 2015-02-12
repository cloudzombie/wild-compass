class Inventory::Plants::BabiesController < InventoryController
  expose(:babies) { Plant::BabyPlant.all }
end