class Api::V1::RoadTripController < ApplicationController
  def create
    
    # travel_time = RouteFacade.get_travel_time(params)
    # location = GeocodeFacade.get_geocode(params[:destination])
    # forecast = ForecastFacade.get_forecast(location)
    # weather_at_eta = forecast.in(travel_time)
    render json: RoadtripSerializer.new(
      RoadTripFacade.get_road_trip(params)
    ), status: :created
  end
end
