;; Created by Ayush Biswas at 2026/10/06 22:23
;; https://atcoder.jp/contests/abc201/tasks/abc201_a
;; A - Tiny Arithmetic Sequence
;;
(ns bin.ac-abc201-a
  (:require [lib.cpio :refer [with-tokens yes-no]]))

;; @code begin

(defn solve [xs]
 (let [[a1 a2 a3] (sort xs)]
   (= (- a2 a1) (- a3 a2))))

(with-tokens '[xs [:ints 3]]
  (comp yes-no solve))

;; @code end

