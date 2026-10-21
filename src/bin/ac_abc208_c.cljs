;; Created by Ayush Biswas at 2026/10/05 17:49
;; https://atcoder.jp/contests/abc208/tasks/abc208_c
;; C - Fair Candy Distribution
;;
(ns bin.ac-abc208-c
  (:require [lib.cpio :refer [with-tokens lines]]))

;; @code begin

(defn solve [n k ids]
  (let [n (js/BigInt n)
        m (js/Number (mod k n))
        privileged (->> ids sort (take m) set)
        i (/ k n)
        j (+ i (js/BigInt 1))]
    (map #(if (privileged %) j i) ids))
  )

(with-tokens '[n :int k :bigint
               ids [:ints n]]
  (comp lines solve))

;; @code end

