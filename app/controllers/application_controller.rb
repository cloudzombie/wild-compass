class ApplicationController < ActionController::Base
  
  # Prevent CSRF attacks by raising an exception.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  rescue_from CanCan::AccessDenied, with: :access_denied

  private

    def access_denied
      if user_signed_in?
        redirect_to access_path
      else
        redirect_to root_path, flash: { alert: "You are not authorized" }
      end
    end
	
end
