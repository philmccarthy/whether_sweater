class GeocodeFacade
  class << self
    def get_geocode(location)
      Location.new(GeocodeService.call_geocode(location))
    end
  end
end