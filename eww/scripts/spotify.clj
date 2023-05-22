#!/usr/bin/env bb

(require 
  '[clojure.java.shell :refer [sh]]
  '[clojure.string :as str]
  '[cheshire.core :as json])

;; retrieves the spotifyd PID
(defn spid []
  (->
    (sh "pgrep" "spotifyd")
    :out
    (str/trim)))

(defn sp-instance []
  (str "org.mpris.MediaPlayer2.spotifyd.instance" (spid)))

(defn sp-method [method]
  (str "org.mpris.MediaPlayer2.Player." method))

(defn sp-thing [thing]
  (str "string:spotify:" thing))

(defn prep-resp [str] 
  {:message str})

(defn send-dbus [method uri]
  (->
    (sh "dbus-send"
      "--print-reply" 
      (str "--dest=" (sp-instance))
      "/org/mpris/MediaPlayer2"
      (sp-method method)
      (sp-thing uri))
    :out
    (str/trim)
    (prep-resp)
    (json/encode)))

(println (send-dbus "OpenUri" "track:2S6yBUXa5KddBV0CqBkcP1"));
