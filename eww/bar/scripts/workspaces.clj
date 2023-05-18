#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]]
         '[clojure.string :as str] 
         '[cheshire.core :as json])

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

(defn wspinfo [] 
  (-> (sh "hyprctl" "workspaces") 
      :out
      (str/trim)
      (str/split #"(?m)^\n")
      (spltgrps)
      (wspobj)
      (active?)
      (json/encode)))

(-> (wspinfo) println)
