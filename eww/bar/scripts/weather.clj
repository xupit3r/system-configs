#!/usr/bin/env bb

(require 
  '[babashka.http-client :as http]
  '[cheshire.core :as json])

;; this will retrieve weather data from Open Meteo
(def API_BASE "https://api.open-meteo.com/v1/forecast")
(def API_QUERY 
  (str
    "?latitude=40.43"
    "&longitude=-79.93"
    "&hourly=temperature_2m,precipitation"
    "&current_weather=true"
    "&temperature_unit=fahrenheit"
    "&windspeed_unit=mph"
    "&precipitation_unit=inch"
    "&forecast_days=1"))
(def API_URL (str API_BASE API_QUERY))
                 

(def WMO 
  {
    0   {:description "Clear sky" :icon "󰖙"}
    1   {:description "Mainly clear" :icon "󰖐"}
    2   {:description "Partly cloudy" :icon ""}
    3   {:description "Overcast" :icon "󰖐"}
    45  {:description "Fog" :icon "󰖑"}
    48  {:description "Fog" :icon "󰖑"}
    51  {:description "Light drizzle" :icon "󰖗"}
    53  {:description "Moderate drizzle" :icon "󰖗"}
    55  {:description "Intense drizzle" :icon "󰖗"}
    56  {:description "Light freezing drizzle" :icon "󰙿"}
    57  {:description "Intense freezing drizzle" :icon "󰙿"}
    61  {:description "Slight rain" :icon "󰖖"}
    63  {:description "Moderate rain" :icon "󰖖"}
    65  {:description "Heavy rain" :icon "󰖖"}
    66  {:description "Light freezing rain" :icon "󰖒"}
    67  {:description "Heavy freezing rain" :icon "󰖒"}
    71  {:description "Light snow" :icon "󰖘"}
    73  {:description "Moderate snow" :icon "󰖘"}
    75  {:description "Heavy snow" :icon "󰼶"}
    77  {:description "Snow grains" :icon "󰵼"}
    80  {:description "Light rain showers" :icon ""}
    81  {:description "Moderate rain showers" :icon ""}
    82  {:description "Heavy rain showers" :icon ""}
    85  {:description "Light snow showers" :icon ""}
    86  {:description "Heavy snow showers" :icon ""}
    95  {:description "Thunderstorms" :icon ""}
    96  {:description "Thunderstorms with slight hail" :icon ""}
    99  {:description "Thunderstorms with heavy hail" :icon ""}})

(defn pull-temperature [data]
  (int (Math/floor (:temperature (:current_weather data)))))

(defn pull-units [data]
  (:temperature_2m (:hourly_units data)))

(defn pull-conditions [data]
  (get WMO 
       (:weathercode (:current_weather data)) 
       {:description "Conditions unavailable." :icon ""}))

(defn relevant [data] 
  {:temperature (pull-temperature data)
   :units (pull-units data)
   :conditions (pull-conditions data)})

(->
  API_URL 
  http/get 
  :body
  (json/decode true)
  relevant
  json/encode
  println)
