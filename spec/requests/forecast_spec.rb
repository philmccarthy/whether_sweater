require 'rails_helper'

describe 'Forecast Request' do
  describe 'GET /api/v1/forecast?location=place' do
    it 'responds with a JSON object with proper properties' do
      params = { location: 'denver,co' }
      get "/api/v1/forecast?location=#{params[:location]}"
      
      response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response).to be_a Hash
      expect(response).to have_key :data
      expect(response[:data]).to be_a Hash

      expect(response[:data]).to have_key :current_weather
      
      expect(response[:data]).to have_key :daily_weather
      
      expect(response[:data]).to have_key :hourly_weather
    end
  end
end