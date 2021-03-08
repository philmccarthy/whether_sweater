class ForecastService
  class << self
    def call_forecast(location)
      response = conn.get("onecall") do |request|
        request.params[:lat] = location.lat
        request.params[:lon] = location.lng
        request.params[:units] = 'imperial'
        request.params[:exclude] = 'minutely,alerts'
      end
      parse(response)
    end

    private

    def conn
      Faraday.new("https://api.openweathermap.org/data/2.5/") do |request|
        request.params[:appid] = ENV['OPEN_WEATHER_KEY']
      end
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
