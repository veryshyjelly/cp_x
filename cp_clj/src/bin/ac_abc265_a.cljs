;; Created by Ayush Biswas at 2026/09/23 21:37
;; https://atcoder.jp/contests/adt_easy_20260617_1/tasks/abc265_a
;; A - Apple
;;
(ns bin.ac-abc265-a
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [x y n]
  (cond (< (* 3 x) y) (* n x)
        :else (+
               (* (quot n 3) y)
               (* (rem n 3) x))))

(with-tokens '[_x :int _y :int _n :int]
  solve)

;; @code end
