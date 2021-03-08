require 'rails_helper'

RSpec.describe GeocodeFacade do
  describe 'class methods' do
    describe '::get_geocode' do
      it 'creates a Location object from GeocodeService data', :vcr do
        params = { location: 'denver,co'}
        location = GeocodeFacade.get_geocode(params[:location])
        expect(location).to be_a Location
        expect(location).to have_attributes(
          lat: 39.738453,
          lng: -104.984853
        )
      end
    end
  end
end
