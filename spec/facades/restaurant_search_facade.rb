require 'rails_helper'

RSpec.describe RestaurantSearchFacade do
  describe 'class methods' do
    describe '::get_recommendation' do
      it 'returns a restaurant recommendation for use in Munchie endpoint', :vcr do
        params = { start: 'denver,co', destination: 'seattle,wa', food: 'seafood' }
        travel_time = '18:24:45'
        restaurant = RestaurantSearchFacade.get_recommendation(params, travel_time)
        
        expect(restaurant).to be_a Hash
        expect(restaurant.keys).to eq([:name, :address])
        expect(restaurant[:name]).to be_a String
        expect(restaurant[:address]).to be_a String
      end
    end
  end
end
