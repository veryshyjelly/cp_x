;; Created by Ayush Biswas at 2026/10/06 21:51
;; https://atcoder.jp/contests/abc205/tasks/abc205_b
;; B - Permutation Check
;;
(ns bin.ac-abc205-b
  (:require [lib.cpio :refer [with-tokens yes-no]]))

;; @code begin

(defn solve [n xs]
  (= (bit-xor
      (apply bit-xor xs)
      (apply bit-xor (range 1 (inc n))))
     0))

(with-tokens '[n :int 
               xs [:ints n]]
  (comp yes-no solve))

;; @code end

