class Inventory::PlantsController < InventoryController

  include SetSortable

  expose(:plants) { Plant.filter( id: params[:id],
                                  strain_id: params[:strain_id],
                                  format_id: params[:format_id],
                                  status_id: params[:status_id])
                         .sort(sort_column, sort_direction) }

end