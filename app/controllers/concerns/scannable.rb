module Scannable
  extend ActiveSupport::Concern

  def scan
    respond_to do |format|
      format.html { redirect_to models_url, notice: "#{hash_match?}" }
      format.json do
        render json: {
          model_name => {
            match: hash_match?
          }
        } 
      end
    end
  end

  private

    def model
      self.send(model_name)
    end

    def model_class
      controller_name.classify.constantize
    end

    def model_name
      controller_name.classify.downcase.to_sym
    end

    def model_params
      params.require(model_name).permit(:scanned_hash)
    end

    def models_url
      url_for(
        controller: controller_name,
        action: :index
      )
    end

    def find_by_datamatrix_hash
      model_class.find_by(datamatrix_hash: model_params[:scanned_hash])
    end

    def hash_match?
      model == find_by_datamatrix_hash
    end

end