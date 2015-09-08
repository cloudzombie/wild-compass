require "application_responder"

class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception

  self.responder = ApplicationResponder

  respond_to :html

end
