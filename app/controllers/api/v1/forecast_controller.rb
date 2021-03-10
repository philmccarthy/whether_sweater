class Api::V1::ForecastController < ApplicationController
  def index
    raise Exceptions::InvalidParams unless params[:location].present?
    
    location = GeocodeFacade.get_geocode(params[:location])
    render json: ForecastSerializer.new(
      ForecastFacade.get_forecast(location)
    )
  end
end
