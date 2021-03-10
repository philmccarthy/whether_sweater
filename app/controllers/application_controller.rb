class ApplicationController < ActionController::API
  rescue_from Exceptions::InvalidParams,
              Exceptions::BadAddress,
              Exceptions::Unauthorized,
              Exceptions::NotFound,
              with: :render_error_response

  def render_error_response(exception)
    render json: exception.to_hash, status: exception.http_status
  end

  private

  def authenticate_api_key
    @current_user = User.find_by(api_key: params[:api_key])
    if !@current_user
      render json: { errors: ['API Key is invalid.'] }, status: :unauthorized
    end
  end
end
