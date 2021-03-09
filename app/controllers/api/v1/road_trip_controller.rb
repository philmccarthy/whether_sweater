class Api::V1::RoadTripController < ApplicationController
  def create
    # Travel Time
    travel_time = RouteFacade.get_travel_time(params)
    
    # Weather at ETA
    location = GeocodeFacade.get_geocode(params[:destination])
    forecast = ForecastFacade.get_forecast(location)
    # travel_time_in_seconds = travel_time.split(/:/).map(&:to_i).inject(0) do |sum, time_element|
    #   sum * 60 + time_element
    # end
    weather_at_eta = forecast.in(travel_time)
    # Roadtrip PORO
    render json: RoadtripSerializer.new(
      RoadTrip.new(params, travel_time, weather_at_eta)
    ), status: :created
  end
end
