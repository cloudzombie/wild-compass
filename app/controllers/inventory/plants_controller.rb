class Inventory::PlantsController < InventoryController

  include SetSortable

  expose(:plants) { Plant.filter( strain: params[:strain_filter],
                                  format: params[:format_filter], 
                                  status: params[:status_filter])
                         .sort(sort_column, sort_direction) }

end