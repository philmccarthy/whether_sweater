class RoadTripFacade
  class << self
    def get_road_trip(params)
      location = GeocodeFacade.get_geocode(params[:destination])
      travel_time = RouteFacade.get_travel_time(params)
      return RoadTrip.new(params, travel_time) if travel_time == 'Impossible route'

      forecast = ForecastFacade.get_forecast(location)
      weather_at_eta = forecast.in(travel_time)
      RoadTrip.new(params, travel_time, weather_at_eta)
    end
  end
end
