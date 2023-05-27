#!/usr/bin/env bb

(ns spotify
  (:require 
    [clojure.java.shell :refer [sh]]
    [clojure.string :as str]
    [cheshire.core :as json]))

(defn get-text [track] 
  (str (str/join ", " (:artists track))
       " - " 
       (:title track)))

(defn get-alt [track]
  (str (get-text track) " (" (:album track) ")"))

(defn prepare [track] 
  {:text (get-text track)
   :alt (get-alt track)
   :tooltip (get-alt track)
   :class "spotify"})

(defn get-track-info []
  (->
    (sh "nc" "-W" "1" "-U" "/home/joe/.cache/ncspot/ncspot.sock")
    :out
    (json/decode true)
    :playable
    (prepare)
    (json/encode)))

(println (get-track-info))

