class Inventory::Plants::MothersController < InventoryController

  include SetSortable

  expose(:mothers) { Plant::MotherPlant.sort(sort_column, sort_direction) }
  
end