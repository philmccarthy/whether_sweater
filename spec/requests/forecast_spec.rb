require 'rails_helper'

describe 'Forecast Request' do
  describe 'GET api forecast for location', :vcr do
    describe 'Happy Path' do
      it 'responds with a JSON object with proper properties' do
        params = { location: 'denver,co' }
        get api_v1_forecast_index_path(params)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)

        expect(parsed_response).to be_a Hash
        expect(parsed_response).to have_key :data
        expect(parsed_response[:data]).to be_a Hash

        expect(parsed_response[:data]).to have_key :id
        expect(parsed_response[:data][:id]).to be_nil
        
        expect(parsed_response[:data]).to have_key :type
        expect(parsed_response[:data][:type]).to eq('forecast')

        expect(parsed_response[:data]).to have_key :attributes
        expect(parsed_response[:data][:attributes]).to be_a Hash

        expect(parsed_response[:data][:attributes]).to have_key :current_weather
        expect(parsed_response[:data][:attributes]).to have_key :daily_weather
        expect(parsed_response[:data][:attributes]).to have_key :hourly_weather
        
        # Structure and data types for Current Weather attribute
        expect(parsed_response[:data][:attributes][:current_weather]).to have_key :datetime
        expect(parsed_response[:data][:attributes][:current_weather][:datetime]).to be_a String

        expect(parsed_response[:data][:attributes][:current_weather]).to have_key :sunrise
        expect(parsed_response[:data][:attributes][:current_weather][:sunrise]).to be_a String

        expect(parsed_response[:data][:attributes][:current_weather]).to have_key :sunset
        expect(parsed_response[:data][:attributes][:current_weather][:sunset]).to be_a String

        expect(parsed_response[:data][:attributes][:current_weather]).to have_key :temp
        expect(parsed_response[:data][:attributes][:current_weather][:temp]).to be_a Numeric

        expect(parsed_response[:data][:attributes][:current_weather]).to have_key :feels_like
        expect(parsed_response[:data][:attributes][:current_weather][:feels_like]).to be_a Numeric

        expect(parsed_response[:data][:attributes][:current_weather]).to have_key :humidity
        expect(parsed_response[:data][:attributes][:current_weather][:humidity]).to be_a Numeric

        expect(parsed_response[:data][:attributes][:current_weather]).to have_key :uvi
        expect(parsed_response[:data][:attributes][:current_weather][:uvi]).to be_a Numeric

        expect(parsed_response[:data][:attributes][:current_weather]).to have_key :visibility
        expect(parsed_response[:data][:attributes][:current_weather][:visibility]).to be_a Numeric
        
        expect(parsed_response[:data][:attributes][:current_weather]).to have_key :conditions
        expect(parsed_response[:data][:attributes][:current_weather][:conditions]).to be_a String

        expect(parsed_response[:data][:attributes][:current_weather]).to have_key :icon
        expect(parsed_response[:data][:attributes][:current_weather][:icon]).to be_a String
        
        # Structure and data types for Daily Weather attribute
        expect(parsed_response[:data][:attributes][:daily_weather]).to be_an Array
        expect(parsed_response[:data][:attributes][:daily_weather].size).to eq(5)

        expect(parsed_response[:data][:attributes][:daily_weather][0]).to be_a Hash

        expect(parsed_response[:data][:attributes][:daily_weather][0]).to have_key :date
        expect(parsed_response[:data][:attributes][:daily_weather][0][:date]).to be_a String

        expect(parsed_response[:data][:attributes][:daily_weather][0]).to have_key :sunrise
        expect(parsed_response[:data][:attributes][:daily_weather][0][:sunrise]).to be_a String

        expect(parsed_response[:data][:attributes][:daily_weather][0]).to have_key :sunset
        expect(parsed_response[:data][:attributes][:daily_weather][0][:sunset]).to be_a String

        expect(parsed_response[:data][:attributes][:daily_weather][0]).to have_key :max_temp
        expect(parsed_response[:data][:attributes][:daily_weather][0][:max_temp]).to be_a Numeric

        expect(parsed_response[:data][:attributes][:daily_weather][0]).to have_key :min_temp
        expect(parsed_response[:data][:attributes][:daily_weather][0][:min_temp]).to be_a Numeric

        expect(parsed_response[:data][:attributes][:daily_weather][0]).to have_key :conditions
        expect(parsed_response[:data][:attributes][:daily_weather][0][:conditions]).to be_a String

        expect(parsed_response[:data][:attributes][:daily_weather][0]).to have_key :icon
        expect(parsed_response[:data][:attributes][:daily_weather][0][:icon]).to be_a String

        # Structure and data types for Hourly Weather attribute
        expect(parsed_response[:data][:attributes][:hourly_weather]).to be_an Array
        expect(parsed_response[:data][:attributes][:hourly_weather].size).to eq(8)

        expect(parsed_response[:data][:attributes][:hourly_weather][0]).to be_a Hash

        expect(parsed_response[:data][:attributes][:hourly_weather][0]).to have_key :time
        expect(parsed_response[:data][:attributes][:hourly_weather][0][:time]).to be_a String

        expect(parsed_response[:data][:attributes][:hourly_weather][0]).to have_key :temp
        expect(parsed_response[:data][:attributes][:hourly_weather][0][:temp]).to be_a Numeric

        expect(parsed_response[:data][:attributes][:hourly_weather][0]).to have_key :conditions
        expect(parsed_response[:data][:attributes][:hourly_weather][0][:conditions]).to be_a String

        expect(parsed_response[:data][:attributes][:hourly_weather][0]).to have_key :icon
        expect(parsed_response[:data][:attributes][:hourly_weather][0][:icon]).to be_a String
      end
    end

    describe 'Sad Path' do
      it 'responds with an error if no location parameter is given' do
        params = { location: '' }
        get api_v1_forecast_index_path(params)
        
        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response).to be_a Hash
        expect(parsed_response.keys).to eq([:errors])
        expect(parsed_response[:errors]).to be_an Array
        expect(parsed_response[:errors][0].keys).to eq([:code, :detail])
        expect(parsed_response[:errors][0][:code]).to be_a String
        expect(parsed_response[:errors][0][:code]).to eq('invalid_parameters')
        expect(parsed_response[:errors][0][:detail]).to be_a String
        expect(parsed_response[:errors][0][:detail]).to eq('Parameters were invalid. Please review the documentation for this endpoint.')
      end

      it 'raises an exception if a given a location that cannot be found' do
        params = { location: 'asldkjfhaslkdfh' }
        get api_v1_forecast_index_path(params)

        expect(response).to_not be_successful

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response.keys).to eq([:errors])
        expect(parsed_response[:errors][0].keys).to eq([:code, :detail])
        expect(parsed_response[:errors][0][:code]).to be_a String
        expect(parsed_response[:errors][0][:code]).to eq('bad_address')
        expect(parsed_response[:errors][0][:detail]).to be_a String
        expect(parsed_response[:errors][0][:detail]).to eq("Are you sure that's a valid location? We couldn't find it!")
      end
    end
  end
end
