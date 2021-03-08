class Api::V1::UsersController < ApplicationController
  def create
    User.create(
      email: params[:email],
      password: params[:password]
    )
    
    require 'pry'; binding.pry
  end
end