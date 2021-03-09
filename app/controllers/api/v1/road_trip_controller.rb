class Api::V1::RoadTripController < ApplicationController
  def create
    raise Exceptions::InvalidParams unless valid?(params)
    render json: RoadtripSerializer.new(
      RoadTripFacade.get_road_trip(params)
    ), status: :created
  end

  private

  def valid?(params)
    params[:origin].present? &&
    params[:destination].present?
  end
end
