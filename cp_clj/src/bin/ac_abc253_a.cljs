;; Created by Ayush Biswas at 2026/09/24 15:48
;; https://atcoder.jp/contests/abc253/tasks/abc253_a
;; A - Median?
;;
(ns bin.ac-abc253-a
  (:require [lib.cpio :refer [with-tokens yes-no]]))

;; @code begin

(defn solve [xs]
  (= (second xs) (second (sort xs))))

(with-tokens '[xs [:ints 3]]
  (comp yes-no solve))

;; @code end

