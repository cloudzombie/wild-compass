require 'base64'

class API::V1::JarsController < API::V1::APIController
  respond_to :json

  def index
    respond_with Jar.all
  end

  def show
    respond_with Jar.find(params[:id])
  end

  def create
    respond_with Jar.create(jar_params)
  end

  def update
    respond_with Jar.update(jar_params)
  end

  def destroy
    respond_with Jar.destroy(params[:id])
  end

  def datamatrix
    render json: {
      data: {
        datamatrix: "data:image/png;base64,#{Base64.strict_encode64(Jar.find(params[:id]).datamatrix)}"
      }
    }
  end

  def label
    send_data Jar.find(params[:id]).label, type: 'image/png', disposition: 'attachment'
  end

  def perform_return
    render json: {
      data: {
        returned: Jar.find(params[:id]).perform_return(current_user)
      }
    }
  end



  private
    
    def jar_params
      params.require(:jar).permit(:name, :ordered_amount, :bag_id, :current_weight, :initial_weight)
    end

end