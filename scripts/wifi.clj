#!/usr/bin/env bb

(ns wifi
  (:require 
    [clojure.java.shell :refer [sh]]
    [clojure.string :as str] 
    [cheshire.core :as json]))

(def OP_DOWN "down")
(def DEVICE_KEY "GENERAL.DEVICE:")
(def EXPECTED_DEVICE "wlp166s0")
(def SSID "GENERAL.CONNECTION:")

;; read the opstate from the system
(defn opstate []
  (-> (sh "zsh" "-c" "cat /sys/class/net/w*/operstate") :out (str/trim)))

;; assign an appropriate icon to the op state
(defn opicon [] (if (= (opstate) OP_DOWN) "󰖪" "󰖩"))

;; create a has for each connection
(defn hash-em [groups] 
  (mapv 
    (fn [group] 
      (reduce (fn [hsh [k v]] 
                (assoc hsh k v)) {} group)) 
    groups))

;; create a pair for each line [key value]
(defn split-em [groups]
  (mapv 
    (fn [lines]
      (mapv #(str/split % #"  +") lines)) 
    groups))

;; split the connection group into lines
(defn line-em [groups]
  (mapv #(str/split % #"\n") groups))

;; split the connections output into groups of text
(defn connections [] 
  (-> (sh "nmcli" "device" "show")
      :out
      (str/split #"(?m)^\n") 
      (line-em) 
      (split-em) 
      (hash-em)))

;; retrieve the active connection
(defn active [] 
  (first 
    (filter 
      #(= (get % DEVICE_KEY "") EXPECTED_DEVICE) 
      (connections))))

;; pull ssid of the active connection
(defn ssid [] (get (active) SSID))

;; prepare some wifi info
(defn wifi-info [] 
  {:state {:icon (opicon)} 
   :connection {:ssid (ssid)}})

(println (json/encode (wifi-info)))

