require_relative "features/alerts"
require_relative "features/current_conditions"
require_relative "features/sunrise_sunset"
require_relative "features/ten_day_forecast"
require_relative "features/helper"

puts "What zip code would you like to know the weather for?"

zip = gets.chomp

if /(^\d{5}-\d{4}$|^\d{9}$|^\d{5}$)/.match(zip)
  puts "Got it.  Hold on while we get you that information."
  # from HTTParty documentation:
  response = HTTParty.get("http://api.wunderground.com/api/b7ba232230dd80b0/conditions/q/#{zip}.json")
  # puts response.body, response.code, response.message, response.headers.inspect

  # current conditions
  puts "The current weather for #{response["current_observation"]["display_location"]["full"]} is:"
  puts response["current_observation"]["weather"]

  # 10 day forecast
  forecast = HTTParty.get("http://api.wunderground.com/api/f54dc0fe16495448/forecast10day/q/#{zip}.json")
  puts "The weather for the next 10 days will be:"

  futureday = 0
  until futureday == 20 do
    puts (forecast["forecast"]["txt_forecast"]["forecastday"][futureday]["title"])+": "+(forecast["forecast"]["txt_forecast"]["forecastday"][futureday]["fcttext"])
    futureday += 1
  end

  # sunrise_sunset
  sun = HTTParty.get("http://api.wunderground.com/api/f54dc0fe16495448/astronomy/q/#{zip}.json")
  puts "Sunrise at: #{(sun["moon_phase"]["sunrise"]["hour"])}"+":"+"#{(sun["moon_phase"]["sunrise"]["minute"])}"+" AM"
  puts "Sunset at: #{((sun["moon_phase"]["sunset"]["hour"]).to_i - (12) )}"+":"+"#{(sun["moon_phase"]["sunset"]["minute"])}"+" PM"

  # alerts
  alerts = HTTParty.get("http://api.wunderground.com/api/f54dc0fe16495448/alerts/q/#{zip}.json")
binding.pry
  puts alerts["0"]["message"]
else
  puts "'#{zip}' is not a known zip code."
end
