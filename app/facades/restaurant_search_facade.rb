class RestaurantSearchFacade
  class << self
    def get_recommendation(params, travel_time)
      response = conn.get('search') do |request|
        request.params[:location] = params[:destination]
        request.params[:term] = params[:food]
        request.params[:open_at] = arrival_time(travel_time)
      end
      format_restaurant_data(
        JSON.parse(response.body, symbolize_names: true)
      )
    end

    private

    def format_restaurant_data(data)
      {
        name: data[:businesses][0][:name],
        address: data[:businesses][0][:location][:display_address].join(', ')
      }
    end

    def conn
      Faraday.new('https://api.yelp.com/v3/businesses/') do |request|
        request.headers[:authorization] = "Bearer #{ENV['YELP_KEY']}"
      end
    end

    def arrival_time(travel_time)
      travel_time_offset = travel_time.split(':')
      (Time.now +
        travel_time_offset[0].to_i.hours +
        travel_time_offset[1].to_i.minutes).to_i
    end
  end
end
