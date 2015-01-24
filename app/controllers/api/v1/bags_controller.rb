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

  def datamatrix
    send_data Bag.find(id_param).label, type: 'image/png', disposition: 'attachment'
  end

  private
    
    def bag_params
      params.require(:bag).permit(:weight, :initial_weight, :container_id, :name, :created_at, :current_weight)
    end

    def id_param
      params[:id]
    end

end