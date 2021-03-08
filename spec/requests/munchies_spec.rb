require 'rails_helper'

describe 'Munchies Request' do
  before :each do
    time_now = DateTime.strptime('1615224628', '%s')
    allow(Time).to receive(:now).and_return(time_now)
  end

  describe 'GET munchies', :vcr do
    describe 'Happy Path' do
      it 'returns a JSON object with proper properties' do
        
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

    describe 'Sad Path' do
      it 'raises an exception if required params are missing' do
        params = { start: 'denver,co' }
        get "/api/v1/munchies?start=#{params[:start]}"

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

      it 'raises an exception if a location cannot be found by geocode API request' do
        params = {start: "denver,co", destination: "asdasfjaskjh" }
        get "/api/v1/munchies?start=#{params[:start]}&destination=#{params[:destination]}"

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
    end
  end
end
