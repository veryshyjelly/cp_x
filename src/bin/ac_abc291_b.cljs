;; Created by Ayush Biswas at 2026/09/28 13:43
;; https://atcoder.jp/contests/abc291/tasks/abc291_b
;; B - Trimmed Mean
;;
(ns bin.ac-abc291-b
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [n arr]
  (->> arr
       sort
       (drop n)
       (take (* 3 n))
       (apply +)
       (#(/ % (* 3 n)))
       double))

(with-tokens '[n :int
               arr [:ints (* 5 n)]]
  solve)

;; @code end

