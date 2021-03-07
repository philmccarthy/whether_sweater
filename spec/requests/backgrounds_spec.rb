require 'rails_helper'

describe 'Backgrounds Request' do
  describe 'GET background image', :vcr do
    it 'responds with a JSON object with proper properties' do
      params = { location: 'denver' }
      get "/api/v1/backgrounds?location=#{params[:location]}"
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(parsed_response).to be_a Hash
      expect(parsed_response).to have_key :data
      expect(parsed_response[:data]).to be_a Hash

      expect(parsed_response[:data]).to have_key :id
      expect(parsed_response[:data][:id]).to be_nil
      
      expect(parsed_response[:data]).to have_key :type
      expect(parsed_response[:data][:type]).to eq('image')

      expect(parsed_response[:data]).to have_key :attributes
      expect(parsed_response[:data][:attributes]).to be_a Hash

      expect(parsed_response[:data][:attributes]).to have_key :url
      expect(parsed_response[:data][:attributes][:url]).to be_a String
      
      expect(parsed_response[:data][:attributes]).to have_key :credit
      expect(parsed_response[:data][:attributes][:credit]).to be_a Hash
      expect(parsed_response[:data][:attributes][:credit].keys).to eq([
        :required_attribution,
        :required_attribution_link,
        :photographer,
        :photographer_url
        ])
      expect(parsed_response[:data][:attributes][:credit][:required_attribution]).to be_a String
      expect(parsed_response[:data][:attributes][:credit][:required_attribution_link]).to be_a String
      expect(parsed_response[:data][:attributes][:credit][:photographer]).to be_a String
      expect(parsed_response[:data][:attributes][:credit][:photographer_url]).to be_a String
      
      expect(parsed_response[:data][:attributes]).to have_key :img_sizes
      expect(parsed_response[:data][:attributes][:img_sizes].keys).to eq([
        :original,
        :large2x,
        :large,
        :medium,
        :small,
        :portrait,
        :landscape,
        :tiny
      ])
      expect(parsed_response[:data][:attributes][:img_sizes][:original]).to be_a String
    end
  end
end
