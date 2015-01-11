class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied, with: :access_denied

  private

    def access_denied
      redirect_to root_path, flash: { alert: "You are not authorized" }
    end
end
