class BusinessesService
  class << self

    
    private
    
    def conn
      Faraday.new('https://api.yelp.com/v3/businesses/') do |request|
        request.headers[:authorization] = "Bearer #{ENV['YELP_KEY']}"
      end
    end
  end
end
