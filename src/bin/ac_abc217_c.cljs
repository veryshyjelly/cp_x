;; Created by Ayush Biswas at 2026/09/24 00:20
;; https://atcoder.jp/contests/abc217/tasks/abc217_c
;; C - Inverse of Permutation
;;
(ns bin.ac-abc217-c
  (:require [lib.cpio :refer [with-tokens words]]))

;; @code begin

(defn solve [n arr]
  (comment "one long solution can be this"
           (let [p (zipmap arr (iterate inc 1))]
             (for [idx (range n)]
               (p (inc idx)))))
   ; but this one is the best
  (->> (range n)
       (sort-by arr)
       (map inc)))

(with-tokens '[n :int
               arr [:ints n]]
  (comp words solve))

;; @code end

