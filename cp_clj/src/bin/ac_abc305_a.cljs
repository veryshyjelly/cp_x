;; Created by Ayush Biswas at 2026/09/28 13:37
;; https://atcoder.jp/contests/abc305/tasks/abc305_a
;; A - Water Station
;;
(ns bin.ac-abc305-a
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [n]
    (->> (mod n 5) ((juxt - (partial - 5))) (sort-by abs) first (+ n)))

(with-tokens '[n :int]
  solve)

;; @code end

