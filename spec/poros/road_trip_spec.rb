require 'rails_helper'

RSpec.describe RoadTrip do
  describe 'initialization' do
    it 'exists and has attributes' do
      params = { origin: 'Denver,CO', destination: 'Seattle,WA' }
      travel_time = "18:24:27"
      weather_at_eta = { temp: 51.35, conditions: 'few clouds' }

      road_trip = RoadTrip.new(params, travel_time, weather_at_eta)

      expect(road_trip).to be_a RoadTrip
      expect(road_trip.start_city).to be_a String
      expect(road_trip.start_city).to eq('Denver,CO')
      expect(road_trip.end_city).to be_a String
      expect(road_trip.end_city).to eq('Seattle,WA')
      expect(road_trip.travel_time).to be_a String
      expect(road_trip.travel_time).to eq('18:24:27')
      expect(road_trip.weather_at_eta).to be_a Hash
      expect(road_trip.weather_at_eta).to eq({
        temperature: 51.35,
        conditions: 'few clouds'
      })
    end

    it 'can instantiate when no forecast was generated because the trip is impossible' do
      params = { origin: 'Denver,CO', destination: 'London,UK' }
      travel_time = "Impossible route"

      road_trip = RoadTrip.new(params, travel_time)

      expect(road_trip.start_city).to eq('Denver,CO')
      expect(road_trip.end_city).to eq('London,UK')
      expect(road_trip.travel_time).to eq('Impossible route')
      expect(road_trip.weather_at_eta).to eq({})
    end
  end
end
