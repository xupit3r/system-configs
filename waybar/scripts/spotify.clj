#!/usr/bin/env bb

(ns spotify
  (:require
    [cheshire.core :as json]
    [clojure.java.shell :refer [sh]]
    [clojure.string :as str]))


(defn get-text
  "retrieves and formats track text for display"
  [track]
  (str (str/join ", " (:artists track))
       " - "
       (:title track)))


(defn get-alt
  "retrieves and formats the alternative text display"
  [track]
  (str (get-text track) " (" (:album track) ")"))


(defn prepare
  "prepares track information for use in waybar"
  [track]
  {:text (get-text track)
   :alt (get-alt track)
   :tooltip (get-alt track)
   :class "spotify"})


(defn get-track-info
  "retrieves track information from ncspot and prepares it for waybar"
  []
  (->
    (sh "nc" "-W" "1" "-U" "/home/joe/.cache/ncspot/ncspot.sock")
    :out
    (json/decode true)
    :playable
    (prepare)
    (json/encode)))


(println (get-track-info))
