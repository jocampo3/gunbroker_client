class ApplicationController < ActionController::API
  rescue_from GunBroker::Error::RequestError, with: :render_gunbroker_request_error
  rescue_from GunBroker::Error::NotFound, with: :render_not_found
  rescue_from GunBroker::Error::NotAuthorized, with: :render_unauthorized

  private

  def render_gunbroker_request_error(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def render_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_unauthorized(exception)
    render json: { error: exception.message }, status: :unauthorized
  end
end
