;; Created by Ayush Biswas at 2026/10/02 20:02
;; https://atcoder.jp/contests/adt_all_20240102_2/tasks/abc225_a
;; A - Distinct Strings
;;
(ns bin.ac-abc225-a
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [s]
  (let [dischars (count (distinct s))]
    (case dischars 
      1 1
      2 3
      3 6)))

(with-tokens '[s :str]
  solve)

;; @code end

