class Api::V1::ForecastController < ApplicationController
  def index
    location = GeocodeFacade.get_geocode(params[:location])
    render json: ForecastSerializer.new(
      ForecastFacade.get_forecast(location)
    )
  end
end
