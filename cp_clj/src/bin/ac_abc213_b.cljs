;; Created by Ayush Biswas at 2026/10/06 18:33
;; https://atcoder.jp/contests/abc213/tasks/abc213_b
;; B - Booby Prize
;;
(ns bin.ac-abc213-b
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [n as]
  (comment  "one solution is this"
            (->> (map vector as (range))
                 (sort >) second second inc))
       ; other (and better) one is this
  (->> (range n)
       (sort-by as >) second inc))

(with-tokens '[n :int
               arr [:ints n]]
  solve)

;; @code end

