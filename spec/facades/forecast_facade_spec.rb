require 'rails_helper'

RSpec.describe ForecastFacade do
  describe 'class methods' do
    describe '::get_forecast' do
      it 'creates a Forecast object from ForecastService data', :vcr do
        params = { location: 'denver,co'}
        location = GeocodeFacade.get_geocode(params[:location])
        forecast = ForecastFacade.get_forecast(location)

        expect(forecast).to be_a Forecast
        expect(forecast.instance_variables).to eq([
          :@current_weather,
          :@daily_weather,
          :@hourly_weather
        ])

        expect(forecast.current_weather).to be_a Hash
        expect(forecast.current_weather.keys).to eq([
          :datetime,
          :sunrise,
          :sunset,
          :temp,
          :feels_like,
          :humidity,
          :uvi,
          :visibility,
          :conditions,
          :icon
        ])

        expect(forecast.daily_weather).to be_an Array
        expect(forecast.daily_weather.size).to eq(5)
        expect(forecast.daily_weather[0]).to be_a Hash
        expect(forecast.daily_weather[0].keys).to eq([
          :date,
          :sunrise,
          :sunset,
          :max_temp,
          :min_temp,
          :conditions,
          :icon
        ])

        expect(forecast.hourly_weather).to be_an Array
        expect(forecast.hourly_weather.size).to eq(8)
        expect(forecast.hourly_weather[0]).to be_a Hash
        expect(forecast.hourly_weather[0].keys).to eq([
          :time,
          :temp,
          :conditions,
          :icon
        ])
      end

      it 'raises a bad address exception if given location is not found by geocode service', :vcr do
        # The call stack routes to the GeocodeService, which prevents a ForecastService 
        # call to the API if coordinates for given location parameter can't be found
        params = { location: 'sdkjfhask'}
        expect { GeocodeFacade.get_geocode(params[:location]) }.to raise_error(Exceptions::BadAddress)
      end
    end
  end
end
