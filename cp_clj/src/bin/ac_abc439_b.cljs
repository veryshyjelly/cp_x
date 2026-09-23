;; Created by Ayush Biswas at 2026/07/25 12:00
;; https://atcoder.jp/contests/adt_easy_20260212_1/tasks/abc439_b
;; C - Happy Number
;;
(ns bin.ac-abc439-b
  (:require [lib.cpio :refer [with-tokens yes-no]]))

;; @code begin

(defn digits [i]
  (if (= (quot i 10) 0) [i]
      (conj (digits (quot i 10)) (rem i 10))))

(defn next-number [i]
  (apply + (map #(* % %) (digits i))))

(defn happy-number? [n]
  (loop [seen #{}
         n n]
    (cond (= n 1) true
          (seen n) false
          :else (recur (conj seen n) (next-number n)))))

(def solve (comp yes-no happy-number?))

(with-tokens '[_n :int]
  solve)

;; @code end
