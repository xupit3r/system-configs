#!/usr/bin/env bb

(ns weather
  (:require
    [babashka.http-client :as http]
    [cheshire.core :as json]
    [clojure.string :as str]))


;; some formats for our output strings
(def MAIN_FORMAT "<span color='#7aa2f7'><big>%s</big></span>  %s<sup><big>°</big></sup>")
(def FORECAST_FORMAT "%s\t<span color='#7aa2f7'><big>%s</big></span>  %d<sup><big>°</big></sup>")


;; this will retrieve weather data from Open Meteo
(def API_BASE "https://api.open-meteo.com/v1/forecast")


;; mateo API query for my current location
(def API_QUERY
  (str
    "?latitude=40.43"
    "&longitude=-79.93"
    "&hourly=temperature_2m,precipitation_probability,weathercode"
    "&current_weather=true"
    "&temperature_unit=fahrenheit"
    "&windspeed_unit=mph"
    "&precipitation_unit=inch"
    "&timezone=America/New_York"
    "&forecast_days=2"))


;; full url base mateo domain/endpoint and query
(def API_URL (str API_BASE API_QUERY))


;; number of hours to send back for forecasts
(def FORECAST_HOURS 12)


(def WMO
  {0   {:description "clear sky" :icon "󰖙"}
   1   {:description "mainly clear" :icon "󰖐"}
   2   {:description "partly cloudy" :icon ""}
   3   {:description "overcast" :icon "󰖐"}
   45  {:description "fog" :icon "󰖑"}
   48  {:description "fog" :icon "󰖑"}
   51  {:description "light drizzle" :icon "󰖗"}
   53  {:description "moderate drizzle" :icon "󰖗"}
   55  {:description "intense drizzle" :icon "󰖗"}
   56  {:description "light freezing drizzle" :icon "󰙿"}
   57  {:description "intense freezing drizzle" :icon "󰙿"}
   61  {:description "slight rain" :icon "󰖖"}
   63  {:description "moderate rain" :icon "󰖖"}
   65  {:description "heavy rain" :icon "󰖖"}
   66  {:description "light freezing rain" :icon "󰖒"}
   67  {:description "heavy freezing rain" :icon "󰖒"}
   71  {:description "light snow" :icon "󰖘"}
   73  {:description "moderate snow" :icon "󰖘"}
   75  {:description "heavy snow" :icon "󰼶"}
   77  {:description "snow grains" :icon "󰵼"}
   80  {:description "light rain showers" :icon ""}
   81  {:description "moderate rain showers" :icon ""}
   82  {:description "heavy rain showers" :icon ""}
   85  {:description "light snow showers" :icon ""}
   86  {:description "heavy snow showers" :icon ""}
   95  {:description "thunderstorms" :icon ""}
   96  {:description "thunderstorms with slight hail" :icon ""}
   99  {:description "thunderstorms with heavy hail" :icon ""}})


(defn round
  "rounds a number and returns result as an int"
  [num]
  (int (Math/round num)))


(defn get-datetime
  "parses date string and returns a LocalDateTime object refernce"
  [datestr]
  (java.time.LocalDateTime/parse datestr))


(defn timef
  "prepares/formats datetime for display"
  [datetime]
  (-> (java.time.format.DateTimeFormatter/ofPattern "h'<small>'a'</small>'")
      (.format datetime)
      (.toLowerCase)))


(defn from-now
  "filters down forecast days to those that are later than now"
  [forecast]
  (let [now (java.time.LocalDateTime/now)]
    (filterv
      (fn [day] (.isAfter (:datetime day) now))
      forecast)))


(defn to-lines
  "converts forecast to lines for display in the waybar tooltip"
  [forecast]
  (str/join
    "\n"
    (mapv
      #(format
         FORECAST_FORMAT
         (:time %)
         (:icon (:conditions %))
         (:temp %))
      forecast)))


(defn pull-temperature
  "extracts current weather temperature"
  [data]
  (round (:temperature (:current_weather data))))


(defn pull-conditions
  "retrieves the current conditions"
  [data]
  (get WMO
       (:weathercode (:current_weather data))
       {:description "Conditions unavailable." :icon ""}))


(defn pull-hourly
  "extracs the hourly forecast as a sequence of forecast objects"
  [data]
  (let [times (:time (:hourly data))
        temps (:temperature_2m (:hourly data))
        precip (:precipitation_probability (:hourly data))
        codes (:weathercode (:hourly data))]
    (for [idx (range (count times))]
      (let [datetime (get-datetime (get times idx))]
        {:time (timef datetime)
         :datetime datetime
         :temp (round (get temps idx))
         :precip (get precip idx)
         :conditions (get WMO (get codes idx))}))))


(defn pull-tooltip
  "extracts and prepares the tooltip (forecase) data for waybar"
  [data]
  (-> data
      (pull-hourly)
      (from-now)
      (subvec 0 FORECAST_HOURS)
      (to-lines)))


(defn waybar-fmt
  "formats weather data for use in waybar"
  [data]
  (let [conditions (pull-conditions data)
        temperature (pull-temperature data)
        tooltip (pull-tooltip data)]
    {:text (format
             MAIN_FORMAT
             (:icon conditions)
             temperature)
     :tooltip tooltip
     :class "weather"}))


(->
  API_URL
  http/get
  :body
  (json/decode true)
  waybar-fmt
  json/encode
  println)
