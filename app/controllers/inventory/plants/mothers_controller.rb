class Inventory::Plants::MothersController < InventoryController

  include SetSortable

  expose(:mothers) { Plant::MotherPlant.filter(filter_params).sort(sort_column, sort_direction) }

  private

    def filter_params
      if params[:filter].nil?
        {}
      else
        params.require(:filter).permit(:id, :strain_id, :format_id, :status_id)
      end
    end
  
end