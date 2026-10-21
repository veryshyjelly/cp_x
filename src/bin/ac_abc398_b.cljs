;; Created by Ayush Biswas at 2026/09/28 14:49
;; https://atcoder.jp/contests/abc398/tasks/abc398_b
;; B - Full House 3
;;
(ns bin.ac-abc398-b
  (:require [lib.cpio :refer [with-tokens yes-no]]))

;; @code begin

(defn solve [cards]
  (->> cards frequencies vals (sort >)
       ((juxt (comp (partial <= 3) first) 
              (comp (partial <= 2) second)))
       (every? identity)))

(with-tokens '[cards [:ints 7]]
  (comp yes-no solve))

;; @code end

