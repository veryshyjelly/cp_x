;; Created by Ayush Biswas at 2026/10/11 17:40
;; https://atcoder.jp/contests/abc180/tasks/abc180_c
;; C - Cream puff
;;
(ns bin.ac-abc180-c
  (:require [lib.cpio :refer [with-tokens lines]]))

;; @code begin

(defn solve [n]
  (->> (for [i (range (js/Math.sqrt n))
             :let [j (inc i)]
             :when (= 0 (mod n j))] [j (/ n j)])
       (apply concat) sort distinct))

(with-tokens '[n :int]
  (comp lines solve))

;; @code end

