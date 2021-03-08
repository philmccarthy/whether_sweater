class RouteFacade
  class << self
    def get_travel_time(params)
      # response = Faraday.get('http://www.mapquestapi.com/directions/v2/route') do |request|
      #   request.params[:key] = ENV['MAP_QUEST_KEY']
      #   request.params[:from] = params[:start]
      #   request.params[:to] = params[:destination]
      # end
      # parsed = JSON.parse(response.body, symbolize_names: true)
      route = RouteService.call_route(params)
      travel_time = route[:route][:formattedTime]
    end
  end
end