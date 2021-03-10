require 'rails_helper'

RSpec.describe RouteService do
  describe 'class methods' do
    describe '::call_route', :vcr do
      it 'returns a route from origin to destination with statuscode 0' do
        params = { origin: 'denver,co', destination: 'seattle,wa' }
        route_response = RouteService.call_route(params)
    
        expect(route_response).to be_a Hash
        expect(route_response).to have_key :route
        expect(route_response).to have_key :info
        expect(route_response[:route]).to be_a Hash
        expect(route_response[:route]).to have_key :formattedTime
        expect(route_response[:route][:formattedTime]).to be_a String 

        expect(route_response[:info]).to be_a Hash
        expect(route_response[:info]).to have_key :statuscode
        expect(route_response[:info][:statuscode]).to eq(0)
      end

      it 'sad path: returns data saying the requested route is impossible with statuscode != 0' do
        params = { origin: 'denver,co', destination: 'london,uk' }
        route_response = RouteService.call_route(params)

        expect(route_response).to be_a Hash
        expect(route_response).to have_key :route
        expect(route_response).to have_key :info
        expect(route_response[:info]).to be_a Hash
        expect(route_response[:info]).to have_key :statuscode
        expect(route_response[:info][:statuscode]).to_not eq(0)
        expect(route_response[:info][:messages][0]).to eq('We are unable to route with the given locations.')
      end
    end
  end
end
