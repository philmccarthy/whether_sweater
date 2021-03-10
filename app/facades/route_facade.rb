class RouteFacade
  class << self
    def get_travel_time(params)
      route = RouteService.call_route(params)
      return 'Impossible route' if !route[:info][:statuscode].zero?
      route[:route][:formattedTime]
    end
  end
end
