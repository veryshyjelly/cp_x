;; Created by Ayush Biswas at 2026/10/02 20:12
;; https://atcoder.jp/contests/adt_easy_20231130_2/tasks/abc214_b
;; C - How many?
;;
(ns bin.ac-abc214-b
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [s t]
  (let [s' (inc s)]
    (apply + (for [a (range s') b (range s') c (range s')]
       (if (and (<= (+ a b c) s) (<= (* a b c) t)) 1 0)))))

(with-tokens '[s :int t :int]
  solve)

;; @code end

