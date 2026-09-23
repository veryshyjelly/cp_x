;; Created by Ayush Biswas at 2026/09/23 15:26
;; https://atcoder.jp/contests/abc398/tasks/abc398_c
;; C - Uniqueness
;;
(ns bin.ac-abc398-c
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [_n arr]
  (let [larget-key (apply max -1
                          (for [[k v] (frequencies arr)
                                :when (= v 1)]
                            k))
        res (.indexOf arr larget-key)]
    (if (= res -1) -1 (inc res))))

(with-tokens '[n :int
              _arr [:ints n]]
  solve)

;; @code end

