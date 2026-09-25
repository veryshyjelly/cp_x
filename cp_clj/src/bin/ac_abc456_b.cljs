;; Created by Ayush Biswas at 2026/07/25 11:09
;; https://atcoder.jp/contests/adt_all_20260615_2/tasks/abc456_b
;; D - 456
;;
(ns bin.ac-abc456-b
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [a b c]
  (->> (for [ai a bi b ci c
             :let [turn (sort [ai bi ci])]
             :when (= turn [4 5 6])] 1)
       (apply +)
       (#(/ % (* 6 6 6)))
       double))

(with-tokens '[a [:ints 6]
               b [:ints 6]
               c [:ints 6]]
  solve)

;; @code end
