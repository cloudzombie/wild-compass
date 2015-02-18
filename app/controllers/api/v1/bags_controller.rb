class API::V1::BagsController < API::V1::APIController
  respond_to :json

  def index
    respond_with Bag.all
  end

  def show
    respond_with Bag.find(id_param)
  end

  def create
    respond_with Bag.create(bag_params)
  end

  def update
    respond_with Bag.update(bag_params)
  end

  def destroy
    respond_with Bag.destroy(id_param)
  end

  def datamatrix
    send_data Bag.find(id_param).datamatrix, type: 'image/png', disposition: 'attachment'
  end

  def label
    send_data Bag.find(id_param).label, type: 'image/png', disposition: 'attachment'
  end

  def recall
    render json: {
      data: {
        recall: Bag.find(id_param).recall,
        quantity: Bag.find(id_param).lot.initial_weight
      }
    }
  end

  def unrecall
    render json: {
      data: {
        unrecall: Bag.find(id_param).unrecall,
        quantity: Bag.find(id_param).lot.initial_weight
      }
    }
  end

  def quarantine
    render json: {
      data: {
        quarantine: Bag.find(id_param).quarantine,
        quantity: Bag.find(id_param).lot.initial_weight
      }
    }
  end

  def unquarantine
    render json: {
      data: {
        unquarantine: Bag.find(id_param).unquarantine,
        quantity: Bag.find(id_param).lot.initial_weight
      }
    }
  end

  private
    
    def bag_params
      params.require(:bag).permit(:weight, :initial_weight, :container_id, :name, :created_at, :current_weight)
    end

    def id_param
      params[:id]
    end

end