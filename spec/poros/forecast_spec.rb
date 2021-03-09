require 'rails_helper'

RSpec.describe Forecast do
  describe 'initialization' do
    it 'exists and has attributes' do
      data = File.read('./spec/fixtures/json_responses/ow_denver_forecast.json')
      parsed_data = JSON.parse(data, symbolize_names: true)
      forecast = Forecast.new(parsed_data)
      
      expect(forecast).to be_a Forecast
      expect(forecast.daily_weather).to be_an Array
      expect(forecast.hourly_weather).to be_an Array

      expect(forecast.current_weather).to be_a Hash
      expect(forecast.current_weather[:datetime]).to be_a String
      expect(forecast.current_weather[:sunrise]).to be_a String
      expect(forecast.current_weather[:sunset]).to be_a String
      expect(forecast.current_weather[:sunset]).to be_a String
      expect(forecast.current_weather[:temp]).to be_a Numeric
      expect(forecast.current_weather[:feels_like]).to be_a Numeric
      expect(forecast.current_weather[:humidity]).to be_a Numeric
      expect(forecast.current_weather[:uvi]).to be_a Numeric
      expect(forecast.current_weather[:visibility]).to be_a Numeric
      expect(forecast.current_weather[:conditions]).to be_a String
      expect(forecast.current_weather[:icon]).to be_a String

      expect(forecast.daily_weather.size).to eq(5)
      expect(forecast.daily_weather[0]).to be_a Hash
      expect(forecast.daily_weather[0][:date]).to be_a String 
      expect(forecast.daily_weather[0][:date]).to eq("Mar 07, 2021")
      expect(forecast.daily_weather[0][:sunrise]).to be_a String 
      expect(forecast.daily_weather[0][:sunrise]).to eq("Sun Mar  7, 06:23")
      expect(forecast.daily_weather[0][:sunset]).to be_a String 
      expect(forecast.daily_weather[0][:sunset]).to eq("Sun Mar  7, 17:58")
      expect(forecast.daily_weather[0][:max_temp]).to be_a Numeric 
      expect(forecast.daily_weather[0][:min_temp]).to be_a Numeric 
      expect(forecast.daily_weather[0][:conditions]).to be_a String
      expect(forecast.daily_weather[0][:icon]).to be_a String

      expect(forecast.hourly_weather.size).to eq(8)
      expect(forecast.hourly_weather[0]).to be_a Hash
      expect(forecast.hourly_weather[0][:time]).to be_a String
      expect(forecast.hourly_weather[0][:time]).to eq("11:00:00")
      expect(forecast.hourly_weather[0][:temp]).to be_a Numeric
      expect(forecast.hourly_weather[0][:conditions]).to be_a String
      expect(forecast.hourly_weather[0][:icon]).to be_a String
    end
  end
end
