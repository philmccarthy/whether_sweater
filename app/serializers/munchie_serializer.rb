class MunchieSerializer
  include JSONAPI::Serializer
  set_id { 'null' }
  attributes :destination_city, :travel_time, :forecast, :restaurant
end
