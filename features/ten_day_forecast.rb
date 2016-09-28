def ten_day_forecast(forecast)
  puts "\n---10 DAY FORECAST---"

  futureday = 0
  until futureday == 20 do
    puts (forecast["forecast"]["txt_forecast"]["forecastday"][futureday]["title"])+": "+(forecast["forecast"]["txt_forecast"]["forecastday"][futureday]["fcttext"])
    futureday += 1
  end
end
