class API::V1::PlantsController < API::V1::APIController
  respond_to :json

  def index
    respond_with Plant.all
  end

  def show
    respond_with Plant.find(id_param)
  end

  def create
    respond_with Plant.create(plant_params)
  end

  def update
    respond_with Plant.update(plant_params)
  end

  def destroy
    respond_with Plant.destroy(id_param)
  end

  private
    
    def plant_params
      params.require(:plant).permit(:name, :strain, :format, :status, :rfid, :origin, :lot_id, :initial_weight, :current_weight)
    end

    def id_param
      params[:id]
    end

end