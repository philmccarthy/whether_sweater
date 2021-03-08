class RestaurantSearchFacade
  class << self
    def get_recommendation(params, travel_time)
      RestaurantSearchService.call_recommendation(params, travel_time)
    end
  end
end
