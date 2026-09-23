;; Created by Ayush Biswas at 2026/07/25 16:58
;; https://atcoder.jp/contests/adt_medium_20250812_3/tasks/abc408_b
;; C - Compression
;;
(ns bin.ac-abc408-b
  (:require [lib.cpio :refer [with-tokens lines words]]))

;; @code begin

(defn solve [_n arr]
  (let [res (apply sorted-set arr)]
    (lines [(count res) (words res)])))

(with-tokens '[n :int
              _arr [:ints n]]
  solve)

;; @code end
