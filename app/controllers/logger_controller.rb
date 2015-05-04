class LoggerController < ApplicationController

  def info
    Rails.logger.info log_params[:message]
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def debug
    Rails.logger.debug log_params[:message]
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def warn
    Rails.logger.warn log_params[:message]
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def error
    Rails.logger.error log_params[:message]
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def fatal
    Rails.logger.fatal log_params[:message]
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def unknown
    Rails.logger.unknown log_params[:message]
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

    def log_params
      params.require(:log).permit(:message)
    end

end
