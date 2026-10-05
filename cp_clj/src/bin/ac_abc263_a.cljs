;; Created by Ayush Biswas at 2026/09/28 13:01
;; https://atcoder.jp/contests/abc263/tasks/abc263_a
;; A - Full House
;;
(ns bin.ac-abc263-a
  (:require [lib.cpio :refer [with-tokens yes-no]]))

;; @code begin

(defn solve [cards]
  (->> cards
       (group-by identity)
       vals
       (map count)
       sort
       (= [2 3])))

(with-tokens '[cards [:ints 5]]
  (comp yes-no solve))

;; @code end

