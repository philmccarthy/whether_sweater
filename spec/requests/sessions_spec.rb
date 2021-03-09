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
        
        post api_v1_sessions_path(headers, params)
        
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
  end
end
