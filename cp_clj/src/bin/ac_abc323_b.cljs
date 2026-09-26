;; Created by Ayush Biswas at 2026/09/25 12:14
;; https://atcoder.jp/contests/abc323/tasks/abc323_b
;; B - Round-Robin Tournament
;;
(ns bin.ac-abc323-b
  (:require [lib.cpio :refer [with-tokens words]]))

;; @code begin

(defn solve [n results]
  (let [wins  (comp count (partial filter #(= \x %)))]
    (sort-by (juxt (comp wins results dec) identity)
             (range 1 (inc n)))))

(with-tokens '[n :int
               arr [:strs n]]
  (comp words solve))

;; @code end

