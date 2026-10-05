;; Created by Ayush Biswas at 2026/09/28 15:30
;; https://atcoder.jp/contests/abc369/tasks/abc369_a
;; A - 369
;;
(ns bin.ac-abc369-a
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [n m]
  (let [d (- m n)]
    (->> d
         ((juxt - (partial * 2) #(/ % 2)))
         (filter int?)
         set
         count)))

(with-tokens '[n :int m :int]
  solve)

;; @code end

