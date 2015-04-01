module SetQuarantineable
  extend ActiveSupport::Concern

  def quarantine
    model.quarantine(current_user)
    respond_to do |format|
      format.html { redirect_to models_url, notice: "#{model_name.to_s.humanize} was successfully quarantined." }
      format.json { head :no_content }
    end
  rescue
    respond_to do |format|
      format.html { redirect_to models_url, notice: "#{model_name.to_s.humanize} was not quarantined." }
      format.json { head :no_content }
    end
  end

  def unquarantine
    model.unquarantine(current_user)
    respond_to do |format|
      format.html { redirect_to models_url, notice: "#{model_name.to_s.humanize} was successfully unquarantined." }
      format.json { head :no_content }
    end
  rescue
    respond_to do |format|
      format.html { redirect_to models_url, notice: "#{model_name.to_s.humanize} was not unquarantined." }
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