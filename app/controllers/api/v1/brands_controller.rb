class API::V1::BrandsController < API::V1::APIController  
  respond_to :json

  def index
    respond_with Brand.all
  end

  def show
    respond_with Brand.find(id_param)
  end

  def create
    respond_with Brand.create(brand_params)
  end

  def update
    respond_with Brand.update(brand_params)
  end

  def destroy
    respond_with Brand.destroy(id_param)
  end

  def available
    render json: {
      data: {
        brand: {
          available: Brand.find(id_param).available?
        }
      }
    }
  end

  private
    
    def brand_params
      params.require(:brand).permit(:name, :description)
    end

    def id_param
      params[:id]
    end

end