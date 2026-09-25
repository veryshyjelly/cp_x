;; Created by Ayush Biswas at 2026/07/24 16:53
;; https://atcoder.jp/contests/adt_all_20260629_2/tasks/abc242_b
;; D - Minimize Ordering
;;
(ns bin.ac-abc242-b
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin
(require '[clojure.string :as str])

(defn solve [s]
  (->> s
       sort
       str/join))

(with-tokens '[s :str] solve)

;; @code end
