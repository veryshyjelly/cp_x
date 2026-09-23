;; Created by Ayush Biswas at 2026/07/25 13:35
;; https://atcoder.jp/contests/adt_easy_20251023_3/tasks/abc419_b
;; D - Get Min
;;
(ns bin.ac-abc419-b
  (:require [lib.cpio :refer [with-tokens lines]]
            ["data-structure-typed" :as ds]))

;; @code begin 

(defn solve [_q queries]
  (let [q (ds/MinPriorityQueue.)]
    (->> queries
         (reduce (fn [res query]
                     (case (first query)
                       :push (do (.add q (second query)) res)
                       :pop (conj res (.pop q))))
                   [])
         lines)))

(with-tokens '[q :int
              _queries [:queries q {1 [:push :int]
                                    2 [:pop]}]]
  solve)

;; @code end
