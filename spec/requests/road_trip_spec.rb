require 'rails_helper'

describe 'Road Trip Request' do
  describe 'GET road trip', :vcr do
    describe 'Happy Path' do
      it 'responds with a JSON object with proper properties' do
        time_now = DateTime.strptime('1615319685', '%s')
        allow(Time).to receive(:now).and_return(time_now)
        
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        params = {
          "origin": "Denver,CO",
          "destination": "Pueblo,CO",
          "api_key": "jgn983hy48thw9begh98h4539h4"
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
      end
    end

    # describe 'Sad Path' do
    # end
  end
end
