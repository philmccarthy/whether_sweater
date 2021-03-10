require 'rails_helper'

RSpec.describe Image do
  describe 'initialization' do
    it 'exists and has attributes' do
      data = {
        :page=>1,
        :per_page=>1,
        :photos=>
         [
           {
             :id=>2706750,
              :width=>6240,
              :height=>4160,
              :url=>"https://www.pexels.com/photo/union-station-building-2706750/",
              :photographer=>"Thomas Ward",
              :photographer_url=>"https://www.pexels.com/@thomasleeward",
              :photographer_id=>220769,
              :avg_color=>"#777272",
              :src=>
                {
                  :original=>"https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg",
                  :large2x=>"https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                  :large=>"https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                  :medium=>"https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg?auto=compress&cs=tinysrgb&h=350",
                  :small=>"https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg?auto=compress&cs=tinysrgb&h=130",
                  :portrait=>"https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                  :landscape=>"https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                  :tiny=>"https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                },
              :liked=>false
            }
          ],
        :total_results=>36,
        :next_page=>"https://api.pexels.com/v1/search/?orientation=landscape&page=2&per_page=1&query=denver"
      }

      image = Image.new(data)

      expect(image).to be_a Image
      expect(image.url).to eq('https://www.pexels.com/photo/union-station-building-2706750/')
      expect(image.img_sizes).to be_a Hash
      expect(image.img_sizes.keys.size).to eq(8)
      expect(image.credit).to eq({
        :required_attribution=>"Photo provided by Pexels",
        :required_attribution_link=>"https://www.pexels.com",
        :photographer=>"Thomas Ward",
        :photographer_url=>"https://www.pexels.com/@thomasleeward"
      })
    end
  end
end
