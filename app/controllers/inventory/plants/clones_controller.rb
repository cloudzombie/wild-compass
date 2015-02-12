class Inventory::Plants::ClonesController < InventoryController

  include SetSortable

  expose(:clones) { Plant::ClonePlant.sort(sort_column, sort_direction) }
  
end