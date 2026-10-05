;; Created by Ayush Biswas at 2026/09/28 13:37
;; https://atcoder.jp/contests/abc305/tasks/abc305_a
;; A - Water Station
;;
(ns bin.ac-abc305-a
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [n]
  (let [r (mod n 5)]
    (->> [(- r) (- 5 r)]
         (sort-by abs)
         first
         (+ n))))

(with-tokens '[n :int]
  solve)

;; @code end

