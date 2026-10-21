;; Created by Ayush Biswas at 2026/09/24 15:18
;; https://atcoder.jp/contests/abc317/tasks/abc317_b
;; B - MissingNo.
;;
(ns bin.ac-abc317-b
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [_n xs]
  (let [a0 (apply min xs) 
        ys (map #(- % a0) (sort xs))]
    (some #(apply not= %) (map vector (range) ys))))

(with-tokens '[n :int
               xs [:ints n]]
  solve)

;; @code end

