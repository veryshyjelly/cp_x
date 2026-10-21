;; Created by Ayush Biswas at 2026/10/06 22:17
;; https://atcoder.jp/contests/abc192/tasks/abc192_c
;; C - Kaprekar Number
;;
(ns bin.ac-abc192-c
  (:require [lib.cpio :refer [with-tokens]]
            [clojure.string :as str]))

;; @code begin
(defn g1 [x] (->> x str (sort >) str/join js/parseInt))
(defn g2 [x] (->> x str sort str/join js/parseInt))
(defn f [x] (- (g1 x) (g2 x)))

(defn solve [n k]
  (nth (iterate f n) k))

(with-tokens '[n :int k :int]
  solve)

;; @code end

