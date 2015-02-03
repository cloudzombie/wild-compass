class API::V1::LotsController < API::V1::APIController
  respond_to :json

  def index
    respond_with Lot.all
  end

  def show
    respond_with Lot.find(id_param)
  end

  def create
    respond_with Lot.create(lot_params)
  end

  def update
    respond_with Lot.update(lot_params)
  end

  def destroy
    respond_with Lot.destroy(id_param)
  end

  def recall
    render json: {
      data: {
        recall: Lot.find(id_param).recall
      }
    }
  end

  def quarantine
    render json: {
      data: {
        recall: Lot.find(id_param).quarantine
      }
    }
  end

  private
    
    def lot_params
      params.require(:lot).permit(:name, :initial_weight, :plant_id, :strain_id, :category, :current_weight)
    end

    def id_param
      params[:id]
    end

end