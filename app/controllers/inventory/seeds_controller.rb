class Inventory::SeedsController < InventoryController
  
  include SetSortable

  expose(:seeds) { Seed.filter(filter_params).sort(sort_column, sort_direction) }

  private

    def filter_params
      if params[:filter].nil?
        {}
      else
        params.require(:filter).permit(:id, :name, :stock, :current_weight)
      end
    end

end