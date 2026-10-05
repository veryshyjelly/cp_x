;; Created by Ayush Biswas at 2026/09/28 14:33
;; https://atcoder.jp/contests/abc260/tasks/abc260_a
;; A - A Unique Letter
;;
(ns bin.ac-abc260-a
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [s]
  (some->> s 
      frequencies
      (filter #(= 1 (val %)))
       first
       key))

(with-tokens '[s :str]
  (comp #(or % -1) solve))

;; @code end

