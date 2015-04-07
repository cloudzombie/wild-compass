class API::V1::BagsController < API::V1::APIController
  respond_to :json

  def index
    respond_with Bag.all
  end

  def show
    respond_with Bag.find(params[:id])
  end

  def create
    respond_with Bag.create(bag_params)
  end

  def update
    respond_with Bag.update(bag_params)
  end

  def destroy
    respond_with Bag.destroy(params[:id])
  end

  def datamatrix
    send_data Bag.find(params[:id]).datamatrix, type: 'image/png', disposition: 'attachment'
  end

  def label
    send_data Bag.find(params[:id]).label, type: 'image/png', disposition: 'attachment'
  end

  def recall
    render json: {
      data: {
        recall: Bag.find(params[:id]).recall(current_user),
        quantity: Bag.find(params[:id]).lot.current_weight
      }
    }
  end

  def unrecall
    render json: {
      data: {
        unrecall: Bag.find(params[:id]).unrecall(current_user),
        quantity: Bag.find(params[:id]).lot.current_weight
      }
    }
  end

  def quarantine
    render json: {
      data: {
        quarantine: Bag.find(params[:id]).quarantine(current_user),
        quantity: Bag.find(params[:id]).lot.current_weight
      }
    }
  end

  def unquarantine
    render json: {
      data: {
        unquarantine: Bag.find(params[:id]).unquarantine(current_user),
        quantity: Bag.find(params[:id]).lot.current_weight
      }
    }
  end

  private
    
    def bag_params
      params.require(:bag).permit(:weight, :initial_weight, :container_id, :name, :created_at, :current_weight)
    end

end