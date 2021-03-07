class Forecast
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather
  def initialize(data)
    @current_weather = {
      datetime: DateTime.strptime(data[:current][:dt].to_s, '%s').strftime('%Y-%m-%dT%l:%M:%S%z'),
      sunrise: DateTime.strptime(data[:current][:sunrise].to_s, '%s').strftime('%Y-%m-%dT%l:%M:%S%z'),
      sunset: DateTime.strptime(data[:current][:sunset].to_s, '%s').strftime('%Y-%m-%dT%l:%M:%S%z'),
      temp: data[:current][:temp],
      feels_like: data[:current][:feels_like],
      humidity: data[:current][:humidity],
      uvi: data[:current][:uvi],
      visibility: data[:current][:visibility],
      conditions: data[:current][:weather][0][:description],
      icon: data[:current][:weather][0][:icon]
    }
    @daily_weather = data[:daily][0..4].map { |day| {
      date: DateTime.strptime(day[:dt].to_s, '%s').strftime('%b %d, %Y'),
      sunrise: DateTime.strptime(day[:sunrise].to_s, '%s').strftime('%Y-%m-%dT%l:%M:%S%z'),
      sunset: DateTime.strptime(day[:sunset].to_s, '%s').strftime('%Y-%m-%dT%l:%M:%S%z'),
      max_temp: day[:temp][:max],
      min_temp: day[:temp][:min],
      conditions: day[:weather][0][:description],
      icon: day[:weather][0][:icon]}
    }
    @hourly_weather = data[:hourly][0..7].map { |hour| {
      time: DateTime.strptime(hour[:dt].to_s, '%s').strftime('%H:%M:%S'),
      temp: hour[:temp],
      conditions: hour[:weather][0][:description],
      icon: hour[:weather][0][:icon]}
    }
  end
end
