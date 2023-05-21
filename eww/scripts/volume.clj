#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]]
         '[clojure.string :as str]
         '[clojure.edn :as edn])

;; retrieve the current volume for our default
;; audio source and return it as an integer for
;; use in the volume widget
(-> (sh "wpctl" "get-volume" "@DEFAULT_AUDIO_SINK@")
    :out
    (str/split #" ")
    (second)
    (str/trim)
    (edn/read-string)
    (* 100)
    (int)
    println)
