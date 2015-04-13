module SetSendableToLab
  extend ActiveSupport::Concern

  def send_to_lab
    model.send_to_lab(current_user)

    respond_to do |format|
      if model.save && model.sent_to_lab?
        format.html { redirect_to models_url, notice: "#{model_name.humanize} was successfully sent to Lab." }
      elsif model.save && !model.sent_to_lab?
        format.html { redirect_to models_url, notice: "#{model_name.humanize} was successfully recovered from lab." }
      elsif model.sent_to_lab?
        format.html { redirect_to models_url, notice: "#{model_name.humanize} could not be recovered." }
      else
        format.html { redirect_to models_url, notice: "#{model_name.humanize} could not be sent." }
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