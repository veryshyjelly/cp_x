;; Created by Ayush Biswas at 2026/09/24 15:18
;; https://atcoder.jp/contests/abc317/tasks/abc317_b
;; B - MissingNo.
;;
(ns bin.ac-abc317-b
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [_n arr]
  (let [mi (apply min arr)
        ma (apply max arr)
        xo (apply bit-xor arr)
        xa (apply bit-xor (range mi (inc ma)))]
    (bit-xor xo xa)))

(with-tokens '[n :int
               arr [:ints n]]
  solve)

;; @code end

