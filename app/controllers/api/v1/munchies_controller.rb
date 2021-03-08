class Api::V1::MunchiesController < ApplicationController
  def index
    # Restaurant - Yelp Fusion business search
    conn = Faraday.new('https://api.yelp.com/v3/businesses/') do |request|
      request.headers[:authorization] = "Bearer #{ENV['YELP_KEY']}"
    end
    
    response = conn.get('search') do |request|
      request.params[:location] = params[:destination]
      request.params[:term] = params[:food]
    end

    parsed = JSON.parse(response.body, symbolize_names: true)
    restaurant = parsed[:businesses][0]
    # Travel time - MQ Route

    response = Faraday.get('http://www.mapquestapi.com/directions/v2/route') do |request|
      request.params[:key] = ENV['MAP_QUEST_KEY']
      request.params[:from] = params[:start]
      request.params[:to] = params[:destination]
    end

    parsed = JSON.parse(response.body, symbolize_names: true)
    travel_time = parsed[:route][:formattedTime]

    # Current forecast - Open Weather
    forecast = ForecastFacade.get_forecast(params[:destination])
    require 'pry'; binding.pry
  end
end