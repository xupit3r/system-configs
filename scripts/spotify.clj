#!/usr/bin/env bb

(ns spotify
  (:require 
    [clojure.java.shell :refer [sh]]
    [clojure.string :as str]
    [cheshire.core :as json]))

(def DBUS_PLAYER_INTERFACE "/org/mpris/MediaPlayer2")
(def DBUS_PROPERTIES "org.freedesktop.DBus.Properties.Get")
(def DBUS_PLAYER_PROPS "string:org.mpris.MediaPlayer2.Player")
(def DBUS_PLAYER_META "string:Metadata")

(def DBUS_GROUPER #"\(([^\)]+)\)")
(def DBUS_ARRAY #"array \[([^\]]+)\]")

;; retrieves the spotifyd PID
(defn spid []
  (->
    (sh "pgrep" "spotifyd")
    :out
    (str/trim)))

(defn sp-instance []
  (str "org.mpris.MediaPlayer2.spotifyd.instance" (spid)))

(defn collapse-val [val]
  (let [matcher (re-matcher DBUS_ARRAY val)
        results (re-find matcher)]
    (if (> (count results) 1)
      (second results)
      val)))
 
(defn tokenize [grp]
  (let [[k v] (str/split grp #"variant")]
    {:key (second (str/split (str/trim k) #":")) 
     :value (str/trim (collapse-val v))}))

(defn prepare [output]
  (->>
    output
    (re-seq DBUS_GROUPER)
    (map second)
    (map tokenize)))

(defn get-track-info []
  (->
    (sh "dbus-send"
      "--print-reply=literal" 
      (str "--dest=" (sp-instance))
      DBUS_PLAYER_INTERFACE 
      DBUS_PROPERTIES
      DBUS_PLAYER_PROPS
      DBUS_PLAYER_META)
    :out
    (str/trim)
    (prepare)
    (json/encode)))

(println (get-track-info))

