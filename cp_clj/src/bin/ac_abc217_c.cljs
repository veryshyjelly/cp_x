;; Created by Ayush Biswas at 2026/09/24 00:20
;; https://atcoder.jp/contests/abc217/tasks/abc217_c
;; C - Inverse of Permutation
;;
(ns bin.ac-abc217-c
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [n m arr]
  (+ n m (reduce + arr)))

(with-tokens '[n :int _m :int
              _arr [:ints n]]
  solve)

;; @code end

