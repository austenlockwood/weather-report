require_relative "features/alerts"
require_relative "features/current_conditions"
require_relative "features/sunrise_sunset"
require_relative "features/ten_day_forecast"
require_relative "features/helper"

puts "What zip code would you like to know the weather for?"

zip = gets.chomp

if /(^\d{5}-\d{4}$|^\d{9}$|^\d{5}$)/.match(zip)
  # from HTTParty documentation:
  response = HTTParty.get("http://api.wunderground.com/api/b7ba232230dd80b0/conditions/q/#{zip}.json")
  # puts response.body, response.code, response.message, response.headers.inspect
  puts "\nShowing information for #{(response["current_observation"]["display_location"]["full"]).upcase}:"

  current_conditions(response)
  ten_day_forecast(HTTParty.get("http://api.wunderground.com/api/f54dc0fe16495448/forecast10day/q/#{zip}.json"))
  sunrise_sunset(HTTParty.get("http://api.wunderground.com/api/f54dc0fe16495448/astronomy/q/#{zip}.json"))
  any_alerts(HTTParty.get("http://api.wunderground.com/api/f54dc0fe16495448/alerts/q/#{zip}.json"))
else
  puts "'#{zip}' is not a known zip code."
end
