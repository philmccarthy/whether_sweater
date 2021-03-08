class ApplicationController < ActionController::API
  rescue_from Exceptions::InvalidParams,
              Exceptions::BadAddress,
              with: :render_error_response

  def render_error_response(exception)
    render json: exception.to_hash, status: exception.http_status
  end
end
