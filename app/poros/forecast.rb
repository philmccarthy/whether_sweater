class Forecast
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather
              
  def initialize(data)
    @current_weather = {
      datetime: Time.at(data[:current][:dt]).strftime('%a %b %e, %H:%M'),
      sunrise: Time.at(data[:current][:sunrise]).strftime('%a %b %e, %H:%M'),
      sunset: Time.at(data[:current][:sunset]).strftime('%a %b %e, %H:%M'),
      temp: data[:current][:temp],
      feels_like: data[:current][:feels_like],
      humidity: data[:current][:humidity],
      uvi: data[:current][:uvi],
      visibility: data[:current][:visibility],
      conditions: data[:current][:weather][0][:description],
      icon: data[:current][:weather][0][:icon]
    }
    @daily_weather = data[:daily][0..4].map { |day| {
      date: Time.at(day[:dt]).strftime('%b %d, %Y'),
      sunrise: Time.at(day[:sunrise]).strftime('%a %b %e, %H:%M'),
      sunset: Time.at(day[:sunset]).strftime('%a %b %e, %H:%M'),
      max_temp: day[:temp][:max],
      min_temp: day[:temp][:min],
      conditions: day[:weather][0][:description],
      icon: day[:weather][0][:icon]}
    }
    @hourly_weather = data[:hourly][0..7].map { |hour| {
      time: Time.at(hour[:dt]).strftime('%H:%M:%S'),
      temp: hour[:temp],
      conditions: hour[:weather][0][:description],
      icon: hour[:weather][0][:icon]}
    }
  end

  def in(travel_time)
    travel_time_seconds = time_to_seconds(travel_time)
    if travel_time_seconds < 32400
      eta = convert(travel_time_seconds)
      eta_hour = eta[1] >= 30 ? eta[0] + 1 : eta[0]
      hourly_weather.find do |forecast|
        forecast[:time].include?(eta_hour.to_s)
      end
    else
      arrival_day = Time.current.in(travel_time_seconds).strftime('%b %d, %Y')
      eta_forecast = daily_weather.find { |forecast| forecast[:date] == arrival_day }
      {
        temp: eta_forecast[:max_temp],
        conditions: eta_forecast[:conditions]
      }
    end
  end

  private

  def time_to_seconds(time)
    time.split(/:/).map(&:to_i).inject(0) do |sum, time_element|
      sum * 60 + time_element
    end
  end

  def convert(time)
    add_time(time)
      .strftime('%H:%M')
      .split(/:/)
      .map(&:to_i)
  end

  def add_time(seconds_to_add)
    Time.at(Time.current.to_i + seconds_to_add)
  end
end
