class PlantsController < ApplicationController
  helper_method :sort_column, :sort_direction

  expose(:plant, params: :plant_params) do
    unless params[:id].nil?
      Plant.find(params[:id])
    else
      Plant.new
    end
  end

  expose(:plants) { Plant.all }
  
  # Create new plant.
  def create 
    self.plant = Plant.new(plant_params)
    plant.current_weight = plant.initial_weight = 0.0
    respond_to do |format|
      if plant.save
        format.html { redirect_to plant, notice: 'Plant was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # Update plant column.
  def update 
    respond_to do |format|
      if plant.update(plant_params)
        format.html { redirect_to plant, notice: 'Plant was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end
  
  # Destroy plant.
  def destroy
    plant.destroy
    respond_to do |format|
      format.html { redirect_to plants_url, notice: 'Plant was successfully destroyed.' }
    end
  end

  private
    def plant_params
      params.require(:plant).permit(:name, :strain_id, :format_id, :status_id, :rfid_id, :lot_id, :initial_weight, :current_weight)
    end

    def sort_column
      %w(id name initial_weight current_weight created_at updated_at).include?(params[:sort]) ? params[:sort] : 'id'
    end

    # Set sort direction to ascending or descending.
    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
