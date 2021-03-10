require 'rails_helper'

describe 'Road Trip Request' do
  let!(:user) { create(:user) }

  describe 'GET road trip' do
    describe 'Happy Path' do
      it 'responds with a JSON object with proper properties' do
        WebMock.allow_net_connect!
        VCR.turned_off {
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        params = {
          "origin": "Denver,CO",
          "destination": "Pueblo,CO",
          "api_key": "sEcUrIkEy"
        }

        post '/api/v1/road_trip', headers: headers, params: params.to_json

        expect(response).to be_successful
        expect(response.status).to eq(201)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response).to be_a Hash
        expect(parsed_response).to have_key :data
        expect(parsed_response[:data]).to be_a Hash
        expect(parsed_response[:data].keys).to eq([:id, :type, :attributes])
        expect(parsed_response[:data][:id]).to be_a String
        expect(parsed_response[:data][:type]).to eq('roadtrip')
        expect(parsed_response[:data][:attributes]).to be_a Hash
        expect(parsed_response[:data][:attributes].keys).to eq([
          :start_city,
          :end_city,
          :travel_time,
          :weather_at_eta
        ])
        expect(parsed_response[:data][:attributes][:start_city]).to be_a String
        expect(parsed_response[:data][:attributes][:end_city]).to be_a String
        expect(parsed_response[:data][:attributes][:travel_time]).to be_a String
        expect(parsed_response[:data][:attributes][:weather_at_eta]).to be_a Hash
        expect(parsed_response[:data][:attributes][:weather_at_eta].keys).to eq([:temperature, :conditions])
        expect(parsed_response[:data][:attributes][:weather_at_eta][:temperature]).to be_a Numeric
        expect(parsed_response[:data][:attributes][:weather_at_eta][:conditions]).to be_a String
        }
      end

      it 'returns a forecast for day of arrival when travel time is longer than 8 hours and all attributes are the same' do
        VCR.turned_off {
        WebMock.allow_net_connect!
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        params = {
          "origin": "Denver,CO",
          "destination": "Seattle,WA",
          "api_key": "sEcUrIkEy"
        }

        post '/api/v1/road_trip', headers: headers, params: params.to_json

        expect(response).to be_successful
        expect(response.status).to eq(201)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response).to be_a Hash
        expect(parsed_response[:data]).to be_a Hash
        expect(parsed_response[:data][:id]).to be_a String
        expect(parsed_response[:data][:type]).to eq('roadtrip')

        expect(parsed_response[:data][:attributes][:start_city]).to be_a String
        expect(parsed_response[:data][:attributes][:end_city]).to be_a String
        expect(parsed_response[:data][:attributes][:travel_time]).to be_a String
        expect(parsed_response[:data][:attributes][:weather_at_eta]).to be_a Hash
        expect(parsed_response[:data][:attributes][:weather_at_eta][:temperature]).to be_a Numeric
        expect(parsed_response[:data][:attributes][:weather_at_eta][:conditions]).to be_a String
        }
      end
    end

    describe 'Sad Path', :vcr do
      it 'returns impossible travel time when the route requested is not really a road trip kind of trip' do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        params = {
          "origin": "Denver,CO",
          "destination": "London,UK",
          "api_key": "sEcUrIkEy"
        }

        post '/api/v1/road_trip', headers: headers, params: params.to_json

        expect(response).to be_successful
        expect(response.status).to eq(201)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response).to be_a Hash
        expect(parsed_response[:data]).to be_a Hash
        expect(parsed_response[:data][:id]).to be_a String
        expect(parsed_response[:data][:id]).to eq('null')
        expect(parsed_response[:data][:type]).to eq('roadtrip')
        
        expect(parsed_response[:data][:attributes][:start_city]).to be_a String
        expect(parsed_response[:data][:attributes][:end_city]).to be_a String
        expect(parsed_response[:data][:attributes][:travel_time]).to eq('Impossible route')
        expect(parsed_response[:data][:attributes][:weather_at_eta]).to be_a Hash
        expect(parsed_response[:data][:attributes][:weather_at_eta]).to be_empty
      end

      it 'throws a BadAddress exception if given a location that GeocodeService cant find', :vcr do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        params = {
          "origin": "Denver,CO",
          "destination": "askjdfhaskj",
          "api_key": "sEcUrIkEy"
        }

        post '/api/v1/road_trip', headers: headers, params: params.to_json

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response.keys).to eq([:errors])
        expect(parsed_response[:errors][0].keys).to eq([:code, :detail])
        expect(parsed_response[:errors][0][:code]).to be_a String
        expect(parsed_response[:errors][0][:code]).to eq('bad_address')
        expect(parsed_response[:errors][0][:detail]).to be_a String
        expect(parsed_response[:errors][0][:detail]).to eq("Are you sure that's a valid location? We couldn't find it!")
      end

      it 'throws an InvalidParams exception if either origin or destination are missing', :vcr do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        params = {
          "origin": "Denver,CO",
          "api_key": "sEcUrIkEy"
        }

        post '/api/v1/road_trip', headers: headers, params: params.to_json

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

      it 'returns unauthorized if an API key is invalid', :vcr do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        params = {
          "origin": "Denver,CO",
          "destination": "askjdfhaskj",
          "api_key": "averyinvalidapikey"
        }

        post '/api/v1/road_trip', headers: headers, params: params.to_json

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response).to be_a Hash
        expect(parsed_response.keys).to eq([:errors])
        expect(parsed_response[:errors]).to be_an Array
        expect(parsed_response[:errors][0]).to eq('API Key is invalid.')
      end

      it 'returns unauthorized if an API key is not provided', :vcr do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        params = {
          "origin": "Denver,CO",
          "destination": "askjdfhaskj"
        }

        post '/api/v1/road_trip', headers: headers, params: params.to_json

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response).to be_a Hash
        expect(parsed_response.keys).to eq([:errors])
        expect(parsed_response[:errors]).to be_an Array
        expect(parsed_response[:errors][0]).to eq('API Key is invalid.')
      end

      it 'doesnt allow the request to be sent as query parameters' do
        params = {
          "origin": "Denver,CO",
          "destination": "Arvada,CO",
          "api_key": "sEcUrIkEy"
        }

        post api_v1_road_trip_index_path(params)

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors][0][:detail]).to eq('Parameters were invalid. Please review the documentation for this endpoint.')
      end
    end
  end
end
