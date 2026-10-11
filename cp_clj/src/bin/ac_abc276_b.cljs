;; Created by Ayush Biswas at 2026/09/24 15:24
;; https://atcoder.jp/contests/abc276/tasks/abc276_b
;; B - Adjacency List
;;
(ns bin.ac-abc276-b
  (:require [lib.cpio :refer [with-tokens lines-of-words]]))

;; @code begin

(defn solve [n _m roads]
  (let [conj' (fnil conj [])
        graph (reduce (fn [g [a b]]
                        (-> g (update a conj' b)
                            (update b conj' a)))
                      {} roads)]
    (for [idx (range n)
          :let [neighbors (graph (inc idx))]]
      (apply vector (count neighbors) (sort neighbors)))))

(with-tokens '[n :int m :int
               roads [:grid-ints m 2]]
  (comp lines-of-words solve))

;; @code end

