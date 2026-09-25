;; Created by Ayush Biswas at 2026/09/24 21:38
;; https://atcoder.jp/contests/abc322/tasks/abc322_c
;; C - Festival
;;
(ns bin.ac-abc322-c
  (:require [lib.cpio :refer [with-tokens lines]]
            ["data-structure-typed" :as ds]))

;; @code begin

(defn solve [n _m arr]
  (let [q (ds/Queue. arr)]
    (for [i (range n)
          :let [j (- (.first q) i 1)]]
      (do
        (when (= j 0) (.shift q))
        j))))

(with-tokens '[n :int m :int
               arr [:ints m]]
  (comp lines solve))

;; @code end

