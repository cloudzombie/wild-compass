class Inventory::JarsController < InventoryController
  
  include SetSortable

  expose(:jars) { Jar.sort(sort_column, sort_direction) }
  
end