;; Created by Ayush Biswas at 2026/09/25 12:14
;; https://atcoder.jp/contests/abc323/tasks/abc323_b
;; B - Round-Robin Tournament
;;
(ns bin.ac-abc323-b
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [n m arr]
  (+ n m (reduce + arr)))

(with-tokens '[n :int m :int
               arr [:ints n]]
  solve)

;; @code end

