module SetRecallable
  extend ActiveSupport::Concern

  def recall
    model.recall
    respond_to do |format|
      format.html { redirect_to models_url, notice: "#{model_name.to_s.humanize} was successfully recalled." }
      format.json { head :no_content }
    end
  rescue
    respond_to do |format|
      format.html { redirect_to models_url, notice: "#{model_name.to_s.humanize} was not recalled." }
      format.json { head :no_content }
    end
  end

  def unrecall
    model.unrecall
    respond_to do |format|
      format.html { redirect_to models_url, notice: "#{model_name.to_s.humanize} was successfully unrecalled." }
      format.json { head :no_content }
    end
  rescue
    respond_to do |format|
      format.html { redirect_to models_url, notice: "#{model_name.to_s.humanize} was not unrecalled." }
      format.json { head :no_content }
    end
  end

  private

    def models_url
      url_for(
        controller: controller_name,
        action: :index
      )
    end

    def model
      self.send(model_name)
    end

    def model_name
      controller_name.classify.downcase.to_sym
    end

end