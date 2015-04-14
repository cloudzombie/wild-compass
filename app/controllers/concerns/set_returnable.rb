module SetReturnable

  def perform_return
    model.perform_return(current_user)

    respond_to do |format|
      format.html { redirect_to models_url, notice: "#{model_name.humanize} was successfully returned." }
      format.json { head :no_content }
    end

  rescue ActiveRecord::RecordInvalid, NoMethodError => e
    Raven.capture_exception(e)
    respond_to do |format|
      format.html { redirect_to models_url, notice: "#{model_name.humanize} was not successfully returned." }
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
      self.send(model_name.to_sym)
    end

    def model_name
      controller_name.classify.downcase
    end

end