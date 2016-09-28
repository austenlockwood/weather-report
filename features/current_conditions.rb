def current_conditions(response)
  puts "\n---CURRENT WEATHER---"
  puts response["current_observation"]["weather"]
end
