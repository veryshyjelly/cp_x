;; Created by Ayush Biswas at 2026/10/11 00:19
;; https://codeforces.com/problemset/problem/1999/A
;; A. A+B Again?
;;
(ns bin.cf-1999-a
  (:require [lib.cpio :refer [with-test-cases]]))

;; @code begin

(defn solve [n]
  (apply + (map js/parseInt n)))

(with-test-cases '[n :str]
  solve)

;; @code end

