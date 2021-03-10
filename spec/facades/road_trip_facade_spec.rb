require 'rails_helper'

describe RoadTripFacade do
  let!(:user) { create(:user) }
  before :each do
    current_time = DateTime.strptime('1615349584', '%s')
    allow(Time).to receive(:current).and_return(current_time)
  end
  describe 'class methods', :vcr do
    describe '::get_road_trip' do
      it 'returns a road trip PORO' do
        params = {
          origin: "Denver,CO",
          destination: "Pueblo,CO"
        }

        road_trip = RoadTripFacade.get_road_trip(params)

        expect(road_trip).to be_a RoadTrip
        expect(road_trip.start_city).to eq(params[:origin])
        expect(road_trip.end_city).to eq(params[:destination])
        expect(road_trip.travel_time).to be_a String
        expect(road_trip.weather_at_eta).to be_a Hash
        expect(road_trip.weather_at_eta.keys).to eq([:temperature, :conditions])
        expect(road_trip.weather_at_eta[:temperature]).to be_a Numeric
        expect(road_trip.weather_at_eta[:conditions]).to be_a String
      end

      it 'returns an impossible route string and no weather data if given a bad road trip destination' do
        params = {
          origin: "Denver,CO",
          destination: "London,UK"
        }

        road_trip = RoadTripFacade.get_road_trip(params)

        expect(road_trip).to be_a RoadTrip
        expect(road_trip.start_city).to eq(params[:origin])
        expect(road_trip.end_city).to eq(params[:destination])
        expect(road_trip.travel_time).to eq('Impossible route')
        expect(road_trip.weather_at_eta).to be_a Hash
        expect(road_trip.weather_at_eta).to be_empty
      end
    end
  end
end
