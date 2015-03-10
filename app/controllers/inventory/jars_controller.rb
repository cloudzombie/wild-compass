class Inventory::JarsController < InventoryController
  
  include SetSortable

  expose(:jars) { Jar.filter(filter_params).sort(sort_column, sort_direction) }

  private

    def filter_params
      if params[:filter].nil?
        {}
      else
        params.require(:filter).permit(:id, :strain, :category, :initial_weight, :current_weight, :waste)
      end
    end
  
end