;; Created by Ayush Biswas at 2026/09/28 12:55
;; https://atcoder.jp/contests/abc365/tasks/abc365_b
;; B - Second Best
;;
(ns bin.ac-abc365-b
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

