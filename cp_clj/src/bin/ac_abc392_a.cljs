;; Created by Ayush Biswas at 2026/07/25 12:03
;; https://atcoder.jp/contests/adt_easy_20260204_2/tasks/abc392_a
;; A - Shuffled Equation
;;
(ns bin.ac-abc392-a
  (:require [lib.cpio :refer [with-tokens yes-no]]))

;; @code begin

(defn solve [as]
  (let [[a b c] (sort as)]
    (yes-no (= c (* a b)))))

(with-tokens '[as [:ints 3]]
  solve)

;; @code end
