;; Created by Ayush Biswas at 2026/09/23 22:00
;; https://atcoder.jp/contests/adt_all_20260624_1/tasks/abc240_b
;; D - Count Distinct Integers
;;
(ns bin.ac-abc240-b
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [_ arr]
  (count (set arr)))

(with-tokens '[n :int
              _arr [:ints n]]
  solve)

;; @code end

