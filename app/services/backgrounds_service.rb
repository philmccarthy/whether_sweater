class BackgroundsService
  class << self
    def call_background(location)
      response = conn.get('search') do |request|
        request.params[:query] = location
        request.params[:per_page] = 1
        request.params[:orientation] = 'landscape'
      end
      parse(response)
    end

    private

    def conn
      Faraday.new('https://api.pexels.com/v1/') do |request|
        request.headers[:authorization] = ENV['PEXELS_KEY']
      end
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
