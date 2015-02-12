class Inventory::LotsController < InventoryController

  include SetSortable

  expose(:lots) { Lot.sort(sort_column, sort_direction) }

end