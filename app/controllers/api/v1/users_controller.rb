class Api::V1::UsersController < ApplicationController
  def create
    raise Exceptions::InvalidParams unless params_valid?

    user = User.create(user_params)
    if user.valid?
      render json: UserSerializer.new(user), status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def params_valid?
    params[:user].present?
  end
end
