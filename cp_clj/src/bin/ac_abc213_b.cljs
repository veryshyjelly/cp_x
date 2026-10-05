;; Created by Ayush Biswas at 2026/09/28 14:00
;; https://atcoder.jp/contests/abc213/tasks/abc213_b
;; B - Booby Prize
;;
(ns bin.ac-abc213-b
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [n arr]
  (->> (range n)
       (sort-by arr)
       reverse
       second
       inc))

(with-tokens '[n :int
               arr [:ints n]]
  solve)

;; @code end

