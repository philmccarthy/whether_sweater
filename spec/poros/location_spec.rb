require 'rails_helper'

RSpec.describe Location do
  describe 'initialization' do
    it 'exists and has lat and lng attributes' do
      data = File.read('./spec/fixtures/json_responses/mq_geocode_denver.json')
      parsed_data = JSON.parse(data, symbolize_names: true)
      location = Location.new(parsed_data)

      expect(location).to be_a Location
      expect(location.lat).to be_a Numeric
      expect(location.lat).to eq(39.738453)
      expect(location.lng).to be_a Numeric
      expect(location.lng).to eq(-104.984853)
    end
  end
end
