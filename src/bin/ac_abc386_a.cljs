;; Created by Ayush Biswas at 2026/07/24 22:06
;; https://atcoder.jp/contests/adt_easy_20260626_1/tasks/abc386_a
;; A - Full House 2
;;
(ns bin.ac-abc386-a
  (:require [lib.cpio :refer [with-tokens yes-no]]))

;; @code begin

(defn solve [cards]
  (->> cards
       set
       count
       (= 2)
       yes-no))

(with-tokens '[cards [:ints 4]] solve)

;; @code end
