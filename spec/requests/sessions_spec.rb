require 'rails_helper'

describe 'Sessions Request' do
  let!(:user) { 
    create(:user, 
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password'
    )}

  describe 'POST new session' do
    describe 'Happy path' do
      it 'creates a session from POST body data and responds with a JSON object with proper properties' do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json'}
        params = {
          "email": "whatever@example.com",
          "password": "password"
        }
        expect(User.count).to eq(1)
        
        post api_v1_sessions_path, headers: headers, params: params.to_json

        expect(User.count).to eq(1)
        
        expect(response).to be_successful
        expect(response.status).to eq(200)

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response).to be_a Hash
        expect(parsed_response).to have_key :data
        expect(parsed_response[:data]).to be_a Hash
        expect(parsed_response[:data].keys).to eq([:id, :type, :attributes])
        expect(parsed_response[:data][:id]).to be_a String
        expect(parsed_response[:data][:type]).to eq('user')
        expect(parsed_response[:data][:attributes]).to be_a Hash
        expect(parsed_response[:data][:attributes].keys).to eq([:email, :api_key])
        expect(parsed_response[:data][:attributes][:email]).to be_a String
        expect(parsed_response[:data][:attributes][:api_key]).to be_a String
      end
    end

    describe 'Sad Path' do
      it 'returns unauthorized exception if password is not authenticated, but doesnt give any hints' do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json'}
        params = {
          "email": "whatever@example.com",
          "password": "incorrect-password"
        }
        
        post api_v1_sessions_path, headers: headers, params: params.to_json

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response).to be_a Hash
        expect(parsed_response.keys).to eq([:errors])
        expect(parsed_response[:errors]).to be_an Array
        expect(parsed_response[:errors].size).to eq(1)
        expect(parsed_response[:errors][0].keys).to eq([:code, :detail])
        expect(parsed_response[:errors][0][:code]).to eq('unauthorized')
        expect(parsed_response[:errors][0][:detail]).to eq('Unauthorized. Please confirm your credentials and try again.')
      end

      it 'returns unauthorized exception if email doesnt exist, but doesnt give any hints' do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json'}
        params = {
          "email": "wrong_email@attacker.com",
          "password": "password"
        }
        
        post api_v1_sessions_path, headers: headers, params: params.to_json

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors][0][:code]).to eq('unauthorized')
        expect(parsed_response[:errors][0][:detail]).to eq('Unauthorized. Please confirm your credentials and try again.')
      end

      it 'returns unauthorized exception if email field isnt provided in the request, but doesnt give any hints' do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json'}
        params = {
          "password": "password"
        }
        
        post api_v1_sessions_path, headers: headers, params: params.to_json

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors][0][:code]).to eq('unauthorized')
        expect(parsed_response[:errors][0][:detail]).to eq('Unauthorized. Please confirm your credentials and try again.')
      end

      it 'returns unauthorized exception if password field isnt provided in the request, but doesnt give any hints' do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json'}
        params = {
          "email": "whatever@example.com"
        }
        
        post api_v1_sessions_path, headers: headers, params: params.to_json

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors][0][:code]).to eq('unauthorized')
        expect(parsed_response[:errors][0][:detail]).to eq('Unauthorized. Please confirm your credentials and try again.')
      end

      it 'returns unauthorized exception if both email & password fields arent provided in the request, but doesnt give any hints' do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json'}
        params = {
          "email": "whatever@example.com"
        }
        
        post api_v1_sessions_path, headers: headers, params: params.to_json

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors][0][:code]).to eq('unauthorized')
        expect(parsed_response[:errors][0][:detail]).to eq('Unauthorized. Please confirm your credentials and try again.')
      end
    end
  end
end
