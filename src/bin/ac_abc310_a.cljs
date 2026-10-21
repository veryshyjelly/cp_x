;; Created by Ayush Biswas at 2026/09/24 22:08
;; https://atcoder.jp/contests/abc310/tasks/abc310_a
;; A - Order Something Else
;;
(ns bin.ac-abc310-a
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [_n actual-price discounted-price dishes-price]
  (apply min actual-price 
         (map (partial + discounted-price) dishes-price)))

(with-tokens '[n :int p :int q :int
               price [:ints n]]
  solve)

;; @code end

