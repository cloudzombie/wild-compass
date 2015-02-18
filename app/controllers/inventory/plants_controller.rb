class Inventory::PlantsController < InventoryController

  include SetSortable

  expose(:plants) { Plant.filter(filtering_params).sort(sort_column, sort_direction) }

  private

    def filtering_params
      params.slice(:id, :type, :strain_id, :format_id, :status_id)
    end

end