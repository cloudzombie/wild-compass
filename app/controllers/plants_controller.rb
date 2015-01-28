class PlantsController < ApplicationController

  before_action :authorized?

  helper_method :sort_column, :sort_direction

  expose(:plant, params: :plant_params) do
    unless params[:id].nil?
      Plant.find(params[:id])
    else
      Plant.new
    end
  end

  expose(:plants) do
    begin
      case sort_column.downcase.to_sym
      when :strain
        Plant.search(params[:search]).joins(:strain).merge(Strain.order(acronym: sort_direction.to_sym)).page(params[:page])

      when :status
        Plant.search(params[:search]).joins(:status).merge(Status.order(name: sort_direction.to_sym)).page(params[:page])

      when :format
        Plant.search(params[:search]).joins(:format).merge(Format.order(name: sort_direction.to_sym)).page(params[:page])

      when :rfid
        Plant.search(params[:search]).joins(:rfid).merge(Rfid.order(name: sort_direction.to_sym)).page(params[:page])

      else
        Plant.search(params[:search]).order(sort_column + ' ' + sort_direction).page(params[:page])

      end

    rescue
      Plant.order(id: :asc).page(params[:page])
    end
  end
  
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

    def sort_column
      %w(id name strain location origin format status rfid initial_weight current_weight created_at updated_at).include?(params[:sort]) ? params[:sort] : 'id'
    end

    # Set sort direction to ascending or descending.
    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end

    def authorized?
      authorize! action_name.to_sym, Plant
    end
end
