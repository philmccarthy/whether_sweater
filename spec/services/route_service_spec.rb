require 'rails_helper'

RSpec.describe RouteService do
  describe 'class methods' do
    describe '::call_route', :vcr do
      it 'returns route for from start to destination' do
        params = { start: 'denver,co', destination: 'seattle,wa', food: 'seafood' }
        route_response = RouteService.call_route(params)
    
        expect(route_response).to be_a Hash
        expect(route_response).to have_key :route
        expect(route_response[:route]).to be_a Hash
        expect(route_response[:route]).to have_key :formattedTime
        expect(route_response[:route][:formattedTime]).to be_a String 
      end
    end
  end
end
