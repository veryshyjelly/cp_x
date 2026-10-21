;; Created by Ayush Biswas at 2026/10/06 22:13
;; https://atcoder.jp/contests/abc175/tasks/abc175_b
;; B - Making Triangle
;;
(ns bin.ac-abc175-b
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [_ sticks]
  (count (for [i sticks j sticks k sticks
               :when (and (< i j) (< j k) (< k (+ i j)))] 1)))

(with-tokens '[n :int
               xs [:ints n]]
  solve)

;; @code end

