class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta
              
  def initialize(params, travel_time, weather_at_eta)
    @start_city = params[:origin]
    @end_city = params[:destination]
    @travel_time = travel_time
    @weather_at_eta = {
      temperature: weather_at_eta[:temp],
      conditions: weather_at_eta[:conditions]
    }
  end
end
