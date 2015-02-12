class Inventory::BagsController < InventoryController

  include SetSortable

  expose(:bags) { Bag.where(tested: false, sent_to_lab: false).sort(sort_column, sort_direction) }

end