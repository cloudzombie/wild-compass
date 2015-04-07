class API::V1::APIController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |e|
    Raven.capture_exception(e)
    render json: {
      success: false,
      errors: ["403 - Access Denied"]
    }, status: 403
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    Raven.capture_exception(e)
    render json: {
      success: false,
      errors: ["404 - Not Found"]
    }, status: 404
  end

  rescue_from ActionController::RoutingError do |e|
    Raven.capture_exception(e)
    render json: {
      success: false,
      errors: ["404 - Not Found"]
    }, status: 404
  end

  rescue_from StandardError do |e|
    Raven.capture_exception(e)
    render json: {
      success: false,
      errors: ["500 - Application Error"]
    }, status: 500
  end

end