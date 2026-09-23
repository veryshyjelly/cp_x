;; Created by Ayush Biswas at 2026/07/25 18:09
;; https://atcoder.jp/contests/adt_medium_20250723_3/tasks/abc409_b
;; D - Citation
;;
(ns bin.ac-abc409-b
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [n arr]
  (reduce (fn [res [i v]]
            (max res (min (- n i) v))) 0
          (map vector (range) (sort arr))))

(with-tokens '[n :int
              _arr [:ints n]]
  solve)

;; @code end
