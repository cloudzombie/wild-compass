class Inventory::LotsController < InventoryController

  include SetSortable

  expose(:lots) { Lot.filter(filter_params).sort(sort_column, sort_direction) }

  private

    def filter_params
      if params[:filter].nil?
        {}
      else
        params.require(:filter).permit(:id, :strain, :category, :current_weight)
      end
    end

end