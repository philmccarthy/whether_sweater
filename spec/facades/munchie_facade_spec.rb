require 'rails_helper'

RSpec.describe MunchieFacade do
  describe 'class methods' do
    describe '::get_munchie' do
      it 'creates a Munchie object from multiple API calls', :vcr do
        time_now = DateTime.strptime('1615224628', '%s')
        allow(Time).to receive(:now).and_return(time_now)
        
        params = { start: 'denver,co', destination: 'seattle,wa', food: 'seafood' }
        munchie = MunchieFacade.get_munchie(params)

        expect(munchie).to be_a Munchie
        expect(munchie.destination_city).to be_a String
        expect(munchie.travel_time).to be_a String
        expect(munchie.forecast).to be_a Hash
        expect(munchie.forecast[:summary]).to be_a String
        expect(munchie.forecast[:temperature]).to be_a String
        expect(munchie.restaurant).to be_a Hash
        expect(munchie.restaurant[:name]).to be_a String
        expect(munchie.restaurant[:address]).to be_a String
      end
    end
  end
end
