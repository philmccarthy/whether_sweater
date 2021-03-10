require 'rails_helper'

RSpec.describe RouteFacade do
  describe 'class methods', :vcr do
    describe '::get_travel_time' do
      it 'returns a travel time for use in road trip endpoint' do
        params = {
          "origin": "Denver,CO",
          "destination": "Pueblo,CO",
        }
        travel_time = RouteFacade.get_travel_time(params)
        expect(travel_time).to be_a String
      end

      it 'returns impossible route if given a destination that cannot be road tripped to' do
        params = {
          "origin": "Denver,CO",
          "destination": "sydney,aus",
        }
        travel_time = RouteFacade.get_travel_time(params)
        expect(travel_time).to eq('Impossible route')
      end

      it 'returns travel time to a generic location if given an unrecognizable location' do
        # Within current implementation of the RouteService, a gibberish request will
        # return travel time to a generic location in the middle of the US. Because
        # the POST /api/v1/road_trip endpoint throws an error if the GeocodeService
        # fails to find a location, this sad path is not handled by the RouteService.
        params = {
          "origin": "Denver,CO",
          "destination": "asfkjahsdkf",
        }
        travel_time = RouteFacade.get_travel_time(params)
        expect(travel_time).to be_a String
      end
    end
  end
end
