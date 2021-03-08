class GeocodeService
  class << self
    def call_geocode(location)
      response = conn.get('address') do |request|
        request.params[:location] = location
        request.params[:maxResults] = 1
      end
      parse(response)
    end

    private

    def conn
      Faraday.new('http://www.mapquestapi.com/geocoding/v1/') do |request|
        request.params[:key] = ENV['MAP_QUEST_KEY']
      end
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end