class Api::V1::ForecastController < ApplicationController
  def index
    location = GeocodeFacade.get_geocode(params[:location])
    require 'pry'; binding.pry
  end
end