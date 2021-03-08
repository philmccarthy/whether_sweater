require 'rails_helper'

RSpec.describe DestinationForecastFacade do
  describe 'class methods' do
    describe '::get_forecast' do
      it 'returns a travel time for use in Munchie endpoint', :vcr do
        params = { start: 'denver,co', destination: 'seattle,wa', food: 'seafood' }
        forecast = DestinationForecastFacade.get_forecast(params)
        expect(forecast).to be_a Hash
        expect(forecast.keys).to eq([:summary, :temperature])
        expect(forecast[:summary]).to be_a String
        expect(forecast[:temperature]).to be_a String
      end
    end
  end
end
