class Inventory::Plants::ClonesController < InventoryController
  expose(:clones) { Plant::ClonePlant.all }
end