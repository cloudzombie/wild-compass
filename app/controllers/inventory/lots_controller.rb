class Inventory::LotsController < InventoryController
  expose(:lots) { Lot.all }
end