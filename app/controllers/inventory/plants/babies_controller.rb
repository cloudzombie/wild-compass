class Inventory::Plants::BabiesController < InventoryController

  include SetSortable

  expose(:babies) { Plant::BabyPlant.sort(sort_column, sort_direction) }

end