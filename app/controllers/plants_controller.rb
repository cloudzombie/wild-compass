class PlantsController < ApplicationController
  expose(:plant, params: :plant_params) { Plant.find(params[:id]) }
  expose(:plants) { Plants.all }

  def create
    self.plant = Plant.new(plant_params)

    respond_to do |format|
      if plant.save
        format.html { redirect_to plant, notice: 'Plant was successfully created.' }
        format.json { render :show, status: :created, location: plant }
      else
        format.html { render :new }
        format.json { render json: plant.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if plant.update(plant_params)
        format.html { redirect_to plant, notice: 'Plant was successfully updated.' }
        format.json { render :show, status: :ok, location: plant }
      else
        format.html { render :edit }
        format.json { render json: plant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    plant.destroy
    respond_to do |format|
      format.html { redirect_to plants_url, notice: 'Plant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def plant_params
      params[:plant]
    end
end
