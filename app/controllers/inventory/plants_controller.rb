class Inventory::PlantsController < InventoryController

  include SetSortable

  expose(:plants) { Plant.sort(sort_column, sort_direction) }

end