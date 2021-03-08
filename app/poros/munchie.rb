class Munchie
  attr_reader :destination_city, :travel_time, :forecast, :restaurant
  def initialize(data)
    @destination_city = data[:destination_city].gsub(/,/, ', ').titleize
    @travel_time = data[:travel_time]
    @forecast = data[:forecast]
    @restaurant = data[:restaurant]
  end
end
