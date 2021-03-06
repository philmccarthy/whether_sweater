require 'rails_helper'

RSpec.describe GeocodeService do
  describe 'class methods' do
    it '::call_geocode', :vcr do
      params = { location: 'denver,co' }
      geocode_response = GeocodeService.call_geocode(params[:location])
  
      expect(geocode_response).to be_a Hash
      expect(geocode_response).to have_key :info
      expect(geocode_response).to have_key :options
      expect(geocode_response[:options][:maxResults]).to eq(1)
      expect(geocode_response).to have_key :results

      expect(geocode_response[:results]).to be_an Array
      expect(geocode_response[:results][0]).to have_key :providedLocation
      expect(geocode_response[:results][0][:providedLocation][:location]).to eq('denver,co')
      
      expect(geocode_response[:results][0]).to have_key :locations
      expect(geocode_response[:results][0][:locations]).to be_an Array
      
      expect(geocode_response[:results][0][:locations][0]).to have_key :latLng
      expect(geocode_response[:results][0][:locations][0][:latLng]).to be_a Hash

      expect(geocode_response[:results][0][:locations][0][:latLng]).to have_key :lat
      expect(geocode_response[:results][0][:locations][0][:latLng][:lat]).to be_a Numeric

      expect(geocode_response[:results][0][:locations][0][:latLng]).to have_key :lng
      expect(geocode_response[:results][0][:locations][0][:latLng][:lng]).to be_a Numeric
    end
  end
end
