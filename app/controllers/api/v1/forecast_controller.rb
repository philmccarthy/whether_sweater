class Api::V1::ForecastController < ApplicationController
  def index
    location = GeocodeFacade.get_geocode(params[:location])

    conn = Faraday.new("https://api.openweathermap.org/data/2.5/") do |request|
      request.params[:appid] = ENV['OPEN_WEATHER_KEY']
    end

    response = conn.get("onecall") do |request|
      request.params[:lat] = location.lat
      request.params[:lon] = location.lng
      request.params[:units] = 'imperial'
      request.params[:exclude] = 'minutely,alerts'
    end

    parsed = JSON.parse(response.body, symbolize_names: true)

    forecast = Forecast.new(parsed)

    render json: ForecastSerializer.new(forecast)
  end
end
