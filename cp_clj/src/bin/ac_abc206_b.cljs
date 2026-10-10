;; Created by Ayush Biswas at 2026/10/09 14:54
;; https://atcoder.jp/contests/abc206/tasks/abc206_b
;; B - Savings
;;
(ns bin.ac-abc206-b
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [n m arr]
  (+ n m (reduce + arr)))

(with-tokens '[n :int m :int
               arr [:ints n]]
  solve)

;; @code end

