module SetDestroyable
  extend ActiveSupport::Concern

  def destruction
    model.destruction(current_user)

    respond_to do |format|
      if model.save && !model.is_destroyed?
        format.html { redirect_to models_url, notice: "#{model_name.humanize} was successfully restored." }
      elsif model.save && model.is_destroyed?
        format.html { redirect_to models_url, notice: "#{model_name.humanize} was successfully destroyed." }
      else
        format.html { redirect_to models_url, notice: "#{model_name.humanize} could not be destroyed/restored." }
      end
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