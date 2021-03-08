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

        post '/users', headers: headers, params: params
      end
    end
  end
end
