class Api::V1::MunchiesController < ApplicationController
  def index
    # Travel time - MQ Route
    response = Faraday.get('http://www.mapquestapi.com/directions/v2/route') do |request|
      request.params[:key] = ENV['MAP_QUEST_KEY']
      request.params[:from] = params[:start]
      request.params[:to] = params[:destination]
    end
    parsed = JSON.parse(response.body, symbolize_names: true)
    travel_time = parsed[:route][:formattedTime]

    # Current forecast - Open Weather
    destination = GeocodeFacade.get_geocode(params[:destination])
    weather_data = ForecastFacade.get_forecast(destination)
    forecast = {
      summary: weather_data.current_weather[:conditions],
      temperature: weather_data.current_weather[:temp]
    }

    # Restaurant - Yelp Fusion business search
    
    conn = Faraday.new('https://api.yelp.com/v3/businesses/') do |request|
      request.headers[:authorization] = "Bearer #{ENV['YELP_KEY']}"
    end
    
    travel_time_offset = travel_time.split(':')
    arrival_time = Time.now + travel_time_offset[0].to_i.hours + travel_time_offset[1].to_i.minutes

    response = conn.get('search') do |request|
      request.params[:location] = params[:destination]
      request.params[:term] = params[:food]
      request.params[:open_at] = arrival_time.to_i
    end

    parsed = JSON.parse(response.body, symbolize_names: true)
    restaurant = parsed[:businesses][0]
  end
end
