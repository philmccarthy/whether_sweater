class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    raise Exceptions::Unauthorized unless user && user.authenticate(params[:password])
    
    render json: UserSerializer.new(user)
  end
end
