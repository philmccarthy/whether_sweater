class RouteFacade
  class << self
    def get_travel_time(params)
      route = RouteService.call_route(params)
      route[:route][:formattedTime]
    end
  end
end
