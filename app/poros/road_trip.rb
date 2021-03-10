class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta
              
  def initialize(params, travel_time, weather_at_eta={})
    @start_city = params[:origin]
    @end_city = params[:destination]
    @travel_time = travel_time
    @weather_at_eta = set_weather(weather_at_eta)
  end

  def set_weather(forecast)
    @weather_at_eta = forecast.blank? ? {} : {
      temperature: forecast[:temp],
      conditions: forecast[:conditions]
    }
  end
end
