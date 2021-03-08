class Api::V1::MunchiesController < ApplicationController
  def index
    travel_time = RouteFacade.get_travel_time(params)
    forecast = DestinationForecastFacade.get_forecast(params)
    restaurant = RestaurantSearchFacade.get_recommendation(params, travel_time)



    # conn = Faraday.new('https://api.yelp.com/v3/businesses/') do |request|
    #   request.headers[:authorization] = "Bearer #{ENV['YELP_KEY']}"
    # end
    
    # travel_time_offset = travel_time.split(':')
    # arrival_time = Time.now + travel_time_offset[0].to_i.hours + travel_time_offset[1].to_i.minutes

    # response = conn.get('search') do |request|
    #   request.params[:location] = params[:destination]
    #   request.params[:term] = params[:food]
    #   request.params[:open_at] = arrival_time.to_i
    # end

    # parsed = JSON.parse(response.body, symbolize_names: true)
    # restaurant = {
    #   name: parsed[:businesses][0][:name],
    #   address: parsed[:businesses][0][:location][:display_address].join(', ')
    # }

    render json: MunchieSerializer.new(Munchie.new({
      destination_city: params[:destination],
      travel_time: travel_time,
      forecast: forecast,
      restaurant: restaurant
    }))
  end
end
