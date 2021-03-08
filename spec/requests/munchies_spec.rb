require 'rails_helper'

describe 'Munchies Request' do
  describe 'GET munchies', :vcr do
    describe 'Happy Path' do
      it 'returns a JSON object with proper properties' do
        time_now = DateTime.strptime('1615224628', '%s')
        allow(Time).to receive(:now).and_return(time_now)
        
        params = { start: 'denver,co', destination: 'seattle,wa', food: 'seafood' }
        get "/api/v1/munchies?start=#{params[:start]}&destination=#{params[:destination]}&food=#{params[:food]}"

        expect(response).to be_successful
        expect(response.status).to eq(200)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response).to be_a Hash
        expect(parsed_response.keys).to eq([:data])
        expect(parsed_response[:data]).to be_a Hash

        expect(parsed_response[:data].keys).to eq([:id, :type, :attributes])

        expect(parsed_response[:data][:id]).to eq('null')
        expect(parsed_response[:data][:type]).to eq('munchie')
        expect(parsed_response[:data][:attributes]).to be_a Hash
        expect(parsed_response[:data][:attributes].keys).to eq([
          :destination_city,
          :travel_time,
          :forecast,
          :restaurant
        ])

        expect(parsed_response[:data][:attributes][:destination_city]).to be_a String
        expect(parsed_response[:data][:attributes][:travel_time]).to be_a String
        expect(parsed_response[:data][:attributes][:forecast]).to be_a Hash
        expect(parsed_response[:data][:attributes][:restaurant]).to be_a Hash

        expect(parsed_response[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
        expect(parsed_response[:data][:attributes][:forecast][:summary]).to be_a String
        expect(parsed_response[:data][:attributes][:forecast][:temperature]).to be_a String
        
        expect(parsed_response[:data][:attributes][:restaurant].keys).to eq([:name, :address])
        expect(parsed_response[:data][:attributes][:restaurant][:name]).to be_a String
        expect(parsed_response[:data][:attributes][:restaurant][:address]).to be_a String
      end
    end
  end
end
