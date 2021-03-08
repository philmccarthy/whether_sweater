require 'rails_helper'

RSpec.describe RouteFacade do
  describe 'class methods' do
    describe '::get_travel_time' do
      it 'returns a travel time for use in Munchie endpoint', :vcr do
        params = { start: 'denver,co', destination: 'seattle,wa', food: 'seafood' }
        travel_time = RouteFacade.get_travel_time(params)
        expect(travel_time).to be_a String
      end
    end
  end
end
