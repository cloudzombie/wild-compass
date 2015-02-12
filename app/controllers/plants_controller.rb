class PlantsController < ApplicationController
  include Authorizable
  include SetSortable

  expose(:plant, params: :plant_params) { params[:id].nil? ? Plant.new : Plant.find(params[:id]) }

  expose(:plants) { Plant.search(params[:search])
                         .sort(sort_column, sort_direction)
                         .page(params[:page]) }
  
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
      params.require(:plant).permit(:name, :origin, :location_id, :strain_id, :format_id, :status_id, :rfid_id, :initial_weight, :current_weight, { container_ids: [:id]})
    end

end
