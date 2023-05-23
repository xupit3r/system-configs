#!/usr/bin/env bb

(ns workspaces
  (:require 
    [clojure.java.shell :refer [sh]]
    [clojure.string :as str] 
    [cheshire.core :as json]))

(defn wspactive [] 
  (-> (sh "hyprctl" "activeworkspace") 
      :out
      (str/trim)
      (str/split #"\n")
      (first)
      (str/trim)
      (str/replace #":" "")))
                

(defn wspprop [obj line]
  (let [tokens (str/split (str/trim line) #":")]
    (if (< (count tokens) 2) 
      (assoc obj "workspace" (get tokens 0))
      (assoc obj 
        (str/trim (get tokens 0)) 
        (str/trim (get tokens 1))))))

(defn wspobj [groups]
  (mapv #(reduce wspprop {} %) groups))

(defn spltgrps [groups] 
  (mapv #(str/split % #"\n") groups))

(defn active? [wsps] 
  (let [active (wspactive)]
    (mapv 
      #(assoc % "active" (= active (get % "workspace"))) 
      wsps)))

(defn eim [workspace]
  (let [matcher (re-matcher #"ID ([0-9]+).+monitor (.+)$" workspace)]
    (if (nil? (re-find matcher))
      []
      (rest (re-groups matcher)))))
      

(defn id-monitor [wsps]
  (mapv 
    (fn [wsp] 
      (let [[id monitor] (eim (get wsp "workspace"))]
        (assoc 
          wsp 
          "id" id 
          "monitor" monitor)))
    wsps))
  

(defn prepare [wsps]
 { :active (first (filterv #(get % "active") wsps))
    :all wsps})

(defn wspinfo [] 
  (some-> (sh "hyprctl" "workspaces") 
      :out
      (str/trim)
      (str/split #"(?m)^\n")
      (spltgrps)
      (wspobj)
      (active?)
      (id-monitor)
      (prepare)
      (json/encode)))

(-> (wspinfo) println)
