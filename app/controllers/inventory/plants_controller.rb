class Inventory::PlantsController < InventoryController

  helper_method :sort_column, :sort_direction

  expose(:plants) { Plant.sort(sort_column, sort_direction) }

  private

    # Set column to sort in order.
    def sort_column
      %w(name initial_weight current_weight created_at updated_at).include?(params[:sort]) ? params[:sort] : 'id'
    end

    # Set sort direction to ascending or descending.
    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end

end