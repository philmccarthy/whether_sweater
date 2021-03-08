class GeocodeFacade
  class << self
    def get_geocode(location)
      geocode = GeocodeService.call_geocode(location)
      raise Exceptions::BadAddress if middle_of_nowhere?(geocode)
      Location.new(geocode)
    end

    private

    def middle_of_nowhere?(geocode)
      geocode[:results][0][:locations][0][:latLng] ==
      {:lat=>39.390897, :lng=>-99.066067}
    end
  end
end
