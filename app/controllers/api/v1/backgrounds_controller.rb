class Api::V1::BackgroundsController < ApplicationController
  def index
    raise Exceptions::InvalidParams unless params[:location].present?
    
    render json: ImageSerializer.new(
      BackgroundsFacade.get_background(params[:location])
    )
  end
end
