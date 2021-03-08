class DestinationForecastFacade
  class << self
    def get_forecast(params)
      destination = GeocodeFacade.get_geocode(params[:destination])
      weather_data = ForecastFacade.get_forecast(destination)
      {
        summary: weather_data.current_weather[:conditions],
        temperature: weather_data.current_weather[:temp].round(0).to_s
      }
    end
  end
end
