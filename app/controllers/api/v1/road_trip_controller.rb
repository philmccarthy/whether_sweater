class Api::V1::RoadTripController < ApplicationController
  before_action :authenticate_api_key, only: [:create]

  def create
    render json: RoadtripSerializer.new(
      RoadTripFacade.get_road_trip(road_trip_params)
    ), status: :created
  end

  private
  
  def road_trip_params
    raise Exceptions::InvalidParams unless valid?(params)
    params.require(:road_trip).permit(:origin, :destination, :api_key)
  end
  
  def valid?(params)
    params[:road_trip].present? &&
    params[:road_trip][:origin].present? &&
    params[:road_trip][:destination].present?
  end
end
