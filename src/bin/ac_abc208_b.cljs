;; Created by Ayush Biswas at 2026/10/02 20:18
;; https://atcoder.jp/contests/abc208/tasks/abc208_b
;; B - Factorial Yen Coin
;;
(ns bin.ac-abc208-b
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin
(def factorial (memoize
                (fn [n] (cond
                          (<= n 0) 1
                          :else (* n (factorial (dec n)))))))
 
(defn solve [n]
  (let [coins (map factorial (range 10 0 -1))]
    (loop [acc 0 n n coins coins]
      (cond
        (= n 0) acc
        :else (recur (+ acc (quot n (first coins)))
                     (rem n (first coins))
                     (rest coins))))))


(with-tokens '[n :int]
  solve)

;; @code end

