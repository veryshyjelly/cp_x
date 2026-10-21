;; Created by Ayush Biswas at 2026/09/24 18:50
;; https://atcoder.jp/contests/abc368/tasks/abc368_b
;; B - Decrease 2 max elements
;;
(ns bin.ac-abc368-b
  (:require [lib.cpio :refer [with-tokens]]
            ["data-structure-typed" :as ds]))

;; @code begin

(defn solve [_n arr]
  (let [q (ds/MaxPriorityQueue. (to-array arr))]
    (loop [i 0]
      (let [a (.poll q) b (.poll q)]
        (if (or (= a 0) (= b 0)) i
            (do
              (.add q (dec a))
              (.add q (dec b))
              (recur (inc i))))))))

(with-tokens '[n :int
               arr [:ints n]]
  solve)

;; @code end

