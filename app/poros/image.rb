class Image
  attr_reader :url, 
              :img_sizes,
              :credit
              
  def initialize(data)
    @url = data[:photos][0][:url]
    @img_sizes = data[:photos][0][:src]
    @credit = {
      required_attribution: 'Photo provided by Pexels',
      required_attribution_link: 'https://www.pexels.com',
      photographer: data[:photos][0][:photographer],
      photographer_url: data[:photos][0][:photographer_url]
    }
  end
end
