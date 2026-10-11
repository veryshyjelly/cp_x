;; Created by Ayush Biswas at 2026/10/06 21:55
;; https://atcoder.jp/contests/abc201/tasks/abc201_b
;; B - Do you know the second highest mountain?
;;
(ns bin.ac-abc201-b
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [_ mountains]
  (->> mountains (sort-by second) reverse second first))

(with-tokens '[n :int
               xs [:many n [:pair :str :int]]]
  solve)

;; @code end

