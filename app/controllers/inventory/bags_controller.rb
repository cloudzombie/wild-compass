class Inventory::BagsController < InventoryController
  expose(:bags) { Bag.where(tested: false, sent_to_lab: false) } 
end