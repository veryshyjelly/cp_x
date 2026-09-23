;; Created by Ayush Biswas at 2026/07/24 22:18
;; https://atcoder.jp/contests/adt_easy_20260625_1/tasks/abc404_a
;; B - Not Found
;;
(ns bin.ac-abc404-a
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [s]
  (let [s (set s)]
    (->> (range (int \a) (inc (int \z)))
         (map char)
         (some #(when-not (s %) %)))))

(with-tokens '[_s :str]
  solve)

;; @code end
