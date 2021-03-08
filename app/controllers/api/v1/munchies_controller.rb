class Api::V1::MunchiesController < ApplicationController
  def index
    render json: MunchieSerializer.new(MunchieFacade.get_munchie(params))
    # travel_time = RouteFacade.get_travel_time(params)
    # forecast = DestinationForecastFacade.get_forecast(params)
    # restaurant = RestaurantSearchFacade.get_recommendation(params, travel_time)

    # render json: MunchieSerializer.new(Munchie.new({
    #   destination_city: params[:destination],
    #   travel_time: travel_time,
    #   forecast: forecast,
    #   restaurant: restaurant
    # }))
  end
end
