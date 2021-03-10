class ForecastSerializer
  include JSONAPI::Serializer
  set_id { 'null' }
  attributes :current_weather, :daily_weather, :hourly_weather
end
