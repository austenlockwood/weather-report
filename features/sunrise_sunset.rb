def sunrise_sunset(sun)
  puts "\n---SUNRISE---\n #{(sun["moon_phase"]["sunrise"]["hour"])}"+":"+"#{(sun["moon_phase"]["sunrise"]["minute"])}"+" AM"
  puts "\n---SUNSET---\n #{((sun["moon_phase"]["sunset"]["hour"]).to_i - (12) )}"+":"+"#{(sun["moon_phase"]["sunset"]["minute"])}"+" PM"
end
