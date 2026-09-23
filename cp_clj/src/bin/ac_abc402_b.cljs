;; Created by Ayush Biswas at 2026/07/25 16:47
;; https://atcoder.jp/contests/adt_easy_20250903_1/tasks/abc402_b
;; D - Restaurant Queue
;;
(ns bin.ac-abc402-b
  (:require [lib.cpio :refer [with-tokens lines]]
            ["data-structure-typed" :as ds]))

;; @code begin

(defn solve [_q queries]
  (let [q (ds/Queue.)]
    (->> queries
         (reduce (fn [res query]
                     (case (first query)
                       :push (do (.push q (second query)) res)
                       :pop (conj res (.shift q))))
                   [])
         lines)))

(with-tokens '[q :int
              _queries [:queries q {1 [:push :int]
                                    2 [:pop]}]]
  solve)

;; @code end
