;; Created by Ayush Biswas at 2026/07/24 23:05
;; https://atcoder.jp/contests/adt_all_20260624_1/tasks/abc240_b
;; D - Count Distinct Integers
;;
;; @head begin
(ns bin.ac-abc240-b)
;; @head end

(require '[lib.cpio :refer [with-tokens]])

;; @code begin

(defn solve [_ arr]
  (count (set arr)))

(with-tokens [n :int
              _arr [:ints n]]
  solve)

;; @code end
