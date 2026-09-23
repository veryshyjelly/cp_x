;; Created by Ayush Biswas at 2026/07/25 11:36
;; https://atcoder.jp/contests/adt_all_20260224_1/tasks/abc440_b
;; D - Trifecta
;;
(ns bin.ac-abc440-b
  (:require [lib.cpio :refer [with-tokens words]]))

;; @code begin

(defn solve [_n horses]
  (->> horses
       (map-indexed #(vector %2 %1))
       sort
       (map (comp inc second))
       (take 3)
       words))

(with-tokens '[n :int
              _horses [:ints n]]
  solve)

;; @code end
