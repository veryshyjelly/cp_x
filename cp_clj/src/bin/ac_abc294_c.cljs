;; Created by Ayush Biswas at 2026/09/24 22:32
;; https://atcoder.jp/contests/abc294/tasks/abc294_c
;; C - Merge Sequences
;;
(ns bin.ac-abc294-c
  (:require [lib.cpio :refer [with-tokens lines words]]))

;; @code begin

(defn solve [n m a b]
  (let [c (zipmap (sort (concat a b))
                  (range 1 (+ n m 1)))]
  (list (map c a) (map c b))))

(with-tokens '[n :int m :int
               a [:ints n]
               b [:ints m]]
  (comp lines (partial map words) solve))

;; @code end

