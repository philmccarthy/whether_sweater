require 'rails_helper'

RSpec.describe BackgroundsService do
  describe 'class methods' do
    describe '::call_background', :vcr do
      it 'returns background to a given destination' do
        params = { location: 'denver' }
        image_response = BackgroundsService.call_background(params[:location])

        expect(image_response).to be_a Hash
        expect(image_response).to have_key :per_page
        
        expect(image_response[:per_page]).to be_a Numeric 
        expect(image_response).to have_key :total_results
        
        expect(image_response[:total_results]).to be_a Numeric 
        expect(image_response).to have_key :photos
        
        expect(image_response[:photos]).to be_an Array 
        expect(image_response[:photos][0]).to be_a Hash
        
        expect(image_response[:photos][0]).to have_key :url
        expect(image_response[:photos][0][:url]).to be_a String 
        
        expect(image_response[:photos][0]).to have_key :photographer
        expect(image_response[:photos][0][:photographer]).to be_a String 
        
        expect(image_response[:photos][0]).to have_key :photographer_url
        expect(image_response[:photos][0][:photographer_url]).to be_a String 
        
        expect(image_response[:photos][0]).to have_key :src
        expect(image_response[:photos][0][:src]).to be_a Hash 
        expect(image_response[:photos][0][:src].keys).to eq([
          :original, :large2x, :large, :medium, 
          :small, :portrait, :landscape, :tiny
        ])
      end

      it 'returns no results if the search term is bad' do
        params = { location: 'sdfjhasgfdj' }
        image_response = BackgroundsService.call_background(params[:location])
        
        expect(image_response).to be_a Hash
        expect(image_response.keys).to eq([:page, :per_page, :photos, :total_results])
        expect(image_response[:photos]).to be_empty
        expect(image_response[:total_results]).to eq(0)
      end
    end
  end
end
