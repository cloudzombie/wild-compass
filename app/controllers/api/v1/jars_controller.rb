class API::V1::JarsController < API::V1::APIController  
  respond_to :json

  def index
    respond_with Jar.all
  end

  def show
    respond_with Jar.find(id_param)
  end

  def create
    respond_with Jar.create(jar_params)
  end

  def update
    respond_with Jar.update(jar_params)
  end

  def destroy
    respond_with Jar.destroy(id_param)
  end

  def datamatrix
    send_data Jar.find(id_param).datamatrix.data, type: jar.datamatrix.content_type, disposition: 'attachment'
  end

  private
    
    def jar_params
      params.require(:jar).permit(:name, :bag_id, :current_weight, :initial_weight)
    end

    def id_param
      params[:id]
    end

end