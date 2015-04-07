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
        recall: Lot.find(id_param).recall(current_user),
        quantity: Lot.find(id_param).current_weight
      }
    }
  end

  def unrecall
    render json: {
      data: {
        unrecall: Lot.find(id_param).unrecall(current_user),
        quantity: Lot.find(id_param).current_weight
      }
    }
  end

  def quarantine
    render json: {
      data: {
        quarantine: Lot.find(id_param).quarantine(current_user),
        quantity: Lot.find(id_param).current_weight
      }
    }
  end

  def unquarantine
    render json: {
      data: {
        unquarantine: Lot.find(id_param).unquarantine(current_user),
        quantity: Lot.find(id_param).current_weight
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