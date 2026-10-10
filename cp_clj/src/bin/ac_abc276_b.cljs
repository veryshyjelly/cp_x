;; Created by Ayush Biswas at 2026/09/24 15:24
;; https://atcoder.jp/contests/abc276/tasks/abc276_b
;; B - Adjacency List
;;
(ns bin.ac-abc276-b
  (:require [lib.cpio :refer [with-tokens words lines]]
            [clojure.set :as set]))

;; @code begin

(defn solve [n _m roads]
  (let [graph (apply merge-with set/union
                     (map (fn [[a b]] {b #{a} a #{b}}) roads))]
    (for [idx (range n)
          :let [neighbors (graph (inc idx))]]
      (apply vector (count neighbors) (sort neighbors)))))

(with-tokens '[n :int m :int
               roads [:grid-ints m 2]]
  (comp lines (partial map words) solve))

;; @code end

