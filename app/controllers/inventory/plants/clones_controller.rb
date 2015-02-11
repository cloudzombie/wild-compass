class Inventory::Plants::ClonesController < InventoryController
  expose(:clones) { Clone.all }
end