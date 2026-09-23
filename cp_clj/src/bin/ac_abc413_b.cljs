;; Created by Ayush Biswas at 2026/07/25 15:23
;; https://atcoder.jp/contests/adt_medium_20250909_3/tasks/abc413_b
;; D - cat 2
;;
(ns bin.ac-abc413-b
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [_n strs]
  (->>   (for [i strs
               j strs
               :when (not= i j)]
           (str i j))
         set
         count))

(with-tokens '[n :int
              _strs [:strs n]]
  solve)

;; @code end
