#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]] 
         '[clojure.string :as str] 
         '[cheshire.core :as json])

;; locations of the battery info we need
(def BATTERY {:status "/sys/class/power_supply/BAT1/status" 
              :capacity "/sys/class/power_supply/BAT1/capacity"})

;; message to show whne battery level is critically low
(def LOW_BATTERY_MESSAGE
  {:level "critical"
   :title "Battery Low!"
   :body "get dat charger and plug it in, pronto!"})

;; retrieve icon based on current status + capacity
(defn icon? [status capacity] 
  (if (= status "Charging") "󱈑" 
    (cond 
      (> capacity 95) "󰁹"
      (> capacity 90) "󰂂"
      (> capacity 80) "󰂁"
      (> capacity 70) "󰂀"
      (> capacity 60) ""
      (> capacity 30) "󰁿"
      (> capacity 40) "󰁾"
      (> capacity 30) "󰁽"
      (> capacity 20) "󰁼"
      (> capacity 10) "󰁻"
      (> capacity 0) "󰁺"
      :else "󰂎")))

;; send a system notification
(defn send-notification [{level :level title :title body :body}]
  (sh "notify-send" "-u" level title body))

;; maybe notify if some notificaiton criteria is met
;; within the current battery infos
(defn notify? [infos]
 (do 
  (cond (< (:capacity infos) 20) 
    (send-notification LOW_BATTERY_MESSAGE))
  infos))

;; retrieve some battery info from the system, bruh
(defn battery? [key] 
  (-> (sh "cat" (key BATTERY)) :out str/trim))

;; retrieve and format system battery status!
(defn get-infos [] 
  (let [status (battery? :status) 
        capacity (Integer/parseInt (battery? :capacity))]
    {:status status 
     :capacity capacity 
     :icon (icon? status capacity)}))

;; retrieve info, check status, and send json back
(-> (get-infos) 
    (notify?) 
    (json/encode) 
    println)


