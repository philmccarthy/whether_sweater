class Api::V1::SessionsController < ApplicationController
  def create
    raise Exceptions::InvalidParams unless params_valid?
    
    user = User.find_by(email: params[:email])
    raise Exceptions::Unauthorized unless user && user.authenticate(params[:password])
    
    render json: UserSerializer.new(user)
  end

  private
  
  def params_valid?
    params[:session].present?
  end
end
