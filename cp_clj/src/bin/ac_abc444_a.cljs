;; Created by Ayush Biswas at 2026/07/25 11:17
;; https://atcoder.jp/contests/adt_easy_20260508_1/tasks/abc444_a
;; A - Repdigit
;;
(ns bin.ac-abc444-a
  (:require [lib.cpio :refer [with-tokens yes-no]]))

;; @code begin

(defn solve [n]
  (->> n
       dedupe
       count
       (= 1)
       yes-no))

(with-tokens '[_n :str]
  solve)

;; @code end
