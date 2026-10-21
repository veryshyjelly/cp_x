;; Created by Ayush Biswas at 2026/09/28 14:45
;; https://atcoder.jp/contests/abc392/tasks/abc392_b
;; B - Who is Missing?
;;
(ns bin.ac-abc392-b
  (:require [lib.cpio :refer [with-tokens lines words]]))

;; @code begin

(defn solve [n _ arr]
  (->> (range 1 (inc n))
       (filter (complement (set arr)))
       (#(lines (list (count %) (words %))))))

(with-tokens '[n :int m :int
               arr [:ints m]]
  solve)

;; @code end

