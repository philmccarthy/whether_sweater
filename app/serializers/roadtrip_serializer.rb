class RoadtripSerializer
  include JSONAPI::Serializer
  set_id { 'null' }
  attributes :start_city, :end_city, :travel_time, :weather_at_eta
end
