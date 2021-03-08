class MunchieFacade
  class << self
    def get_munchie(params)
      travel_time = RouteFacade.get_travel_time(params)
      forecast = DestinationForecastFacade.get_forecast(params)
      restaurant = RestaurantSearchFacade.get_recommendation(params, travel_time)
      create_munchie(params, travel_time, forecast, restaurant)
    end

    private

    def create_munchie(params, travel_time, forecast, restaurant)
      Munchie.new({
        destination_city: params[:destination],
        travel_time: travel_time,
        forecast: forecast,
        restaurant: restaurant
      })
    end
  end
end
