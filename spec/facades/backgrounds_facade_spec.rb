require 'rails_helper'

RSpec.describe BackgroundsFacade do
  describe 'class methods', :vcr do
    describe '::get_background' do
      it 'returns an image PORO' do
        params = { location: 'denver' }
        image = BackgroundsFacade.get_background(params[:location])

        expect(image).to be_a Image
        expect(image.url).to be_a String
        expect(image.img_sizes).to be_a Hash
        expect(image.credit).to be_a Hash
        expect(image.credit.keys).to eq([
          :required_attribution,
          :required_attribution_link,
          :photographer,
          :photographer_url
        ])
        expect(image.credit[:required_attribution]).to eq('Photo provided by Pexels')
        expect(image.credit[:required_attribution_link]).to eq('https://www.pexels.com')
        expect(image.credit[:photographer]).to be_a String
        expect(image.credit[:photographer_url]).to be_a String
      end

      it 'returns an exception if no photo is found from search' do
        params = { location: 'dekjahkajsfha' }
        expect{ BackgroundsFacade.get_background(params[:location])}.to raise_error(Exceptions::NotFound)
      end
    end
  end
end
