class Inventory::SeedsController < InventoryController
  
  include SetSortable

  expose(:seeds) { Seed.sort(sort_column, sort_direction) }

end