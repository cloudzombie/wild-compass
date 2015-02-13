class Inventory::ContainersController < InventoryController

  include SetSortable

  expose(:containers) { Container.sort(sort_column, sort_direction) }
  
end