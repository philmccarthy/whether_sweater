require 'rails_helper'

describe 'Users Request' do
  describe 'POST new user' do
    describe 'Happy Path' do
      it 'creates a user from POST body data and responds with a JSON object with proper properties' do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json'}
        params = {
          "email": "whatever@example.com",
          "password": "password",
          "password_confirmation": "password"
        }
        expect(User.count).to eq(0)

        post '/api/v1/users', headers: headers, params: params.to_json

        expect(User.count).to eq(1)
        expect(response).to be_successful
        expect(response.status).to eq(201)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response).to be_a Hash
        expect(parsed_response[:data]).to be_a Hash
        expect(parsed_response[:data].keys).to eq([:id, :type, :attributes])
        
        expect(parsed_response[:data][:type]).to eq('user')
        expect(parsed_response[:data][:id]).to be_a String
        expect(parsed_response[:data][:attributes]).to be_a Hash

        expect(parsed_response[:data][:attributes].keys).to eq([:email, :api_key])
        expect(parsed_response[:data][:attributes][:email]).to eq('whatever@example.com')
        expect(parsed_response[:data][:attributes][:api_key]).to be_a String
      end
    end

    describe 'Sad Path' do
      it 'doesnt create a user and returns errors if password and password confirmation dont match' do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json'}
        params = {
          "email": "whatever@example.com",
          "password": "password",
          "password_confirmation": "notright"
        }

        post '/api/v1/users', headers: headers, params: params.to_json

        expect(User.count).to eq(0)
        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        
        expect(parsed_response).to be_a Hash
        expect(parsed_response.keys).to eq([:errors])
        expect(parsed_response[:errors][0]).to eq("Password confirmation doesn't match Password")
      end

      it 'doesnt create a user and returns errors if password confirmation is blank' do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json'}
        params = {
          "email": "whatever@example.com",
          "password": "password"
        }

        post '/api/v1/users', headers: headers, params: params.to_json

        expect(User.count).to eq(0)
        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors][0]).to eq("Password confirmation can't be blank")
      end

      it 'doesnt create a user and returns errors if password is blank' do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json'}
        params = {
          "email": "whatever@example.com",
          "password_confirmation": "password"
        }

        post '/api/v1/users', headers: headers, params: params.to_json

        expect(User.count).to eq(0)
        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors][0]).to eq("Password can't be blank")
      end

      it 'doesnt create a user and returns errors if email is blank' do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json'}
        params = {
          "password": "password",
          "password_confirmation": "password"
        }

        post '/api/v1/users', headers: headers, params: params.to_json

        expect(User.count).to eq(0)
        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors][0]).to eq("Email can't be blank")
      end

      it 'doesnt create a user and returns errors if no JSON body is provided' do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json'}

        post '/api/v1/users', headers: headers

        expect(User.count).to eq(0)
        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors].size).to eq(3)
        expect(parsed_response[:errors]).to eq([
          "Password can't be blank",
          "Email can't be blank",
          "Password confirmation can't be blank"
        ])
      end
      
      it 'doesnt create a user and returns errors if email is already taken' do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json'}
        params = {
          "email": "whatever@example.com",
          "password": "password",
          "password_confirmation": "password"
        }
        
        # First request is successful
        post '/api/v1/users', headers: headers, params: params.to_json

        expect(User.count).to eq(1)
        expect(response).to be_successful

        # Second request should fail email uniqueness validation
        post '/api/v1/users', headers: headers, params: params.to_json

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response[:errors][0]).to eq('Email has already been taken')
      end
    end
  end
end
