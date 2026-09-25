;; Created by Ayush Biswas at 2026/09/24 16:52
;; https://atcoder.jp/contests/abc288/tasks/abc288_b
;; B - Qualification Contest
;;
(ns bin.ac-abc288-b
  (:require [lib.cpio :refer [with-tokens lines]]))

;; @code begin

(defn solve [_n m arr]
  (sort (take m arr)))

(with-tokens '[n :int m :int
               arr [:strs n]]
  (comp lines solve))

;; @code end

