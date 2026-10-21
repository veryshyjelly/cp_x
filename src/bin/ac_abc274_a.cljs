;; Created by Ayush Biswas at 2026/09/24 14:38
;; https://atcoder.jp/contests/abc274/tasks/abc274_a
;; A - Batting Average
;;
(ns bin.ac-abc274-a
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [a b]
  (.toFixed (/ b a) 3))

(with-tokens '[a :int b :int]
  solve)

;; @code end

