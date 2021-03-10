class RouteService
  class << self
    def call_route(params)
      response = Faraday.get('http://www.mapquestapi.com/directions/v2/route') do |request|
        request.params[:key] = ENV['MAP_QUEST_KEY']
        request.params[:from] = params[:origin]
        request.params[:to] = params[:destination]
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
