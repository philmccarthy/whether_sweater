class Api::V1::BackgroundsController < ApplicationController
  def index
    render json: ImageSerializer.new(
      BackgroundsFacade.get_background(params[:location])
    )
  end
end
