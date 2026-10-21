;; Created by Ayush Biswas at 2026/09/25 17:43
;; https://atcoder.jp/contests/abc354/tasks/abc354_b
;; B - AtCoder Janken 2
;;
(ns bin.ac-abc354-b
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [n arr]
  (let [total-score (apply + (map second arr))
        win-idx (mod total-score n)
        lexic (sort (map first arr))]
    (nth lexic win-idx)))

(with-tokens '[n :int
               arr [:many n [:pair :str :int]]]
  solve)

;; @code end

