class ForecastFacade
  class << self
    def get_forecast(location)
      Forecast.new(ForecastService.call_forecast(location))
    end
  end
end
