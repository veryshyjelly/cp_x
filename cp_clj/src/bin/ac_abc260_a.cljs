;; Created by Ayush Biswas at 2026/10/06 21:38
;; https://atcoder.jp/contests/abc260/tasks/abc260_a
;; A - A Unique Letter
;;
(ns bin.ac-abc260-a
  (:require [lib.cpio :refer [with-tokens]]))

;; @code begin

(defn solve [s]
  (some->> s  frequencies (some #(when (= 1 (val %)) %)) key))

(with-tokens '[s :str]
  (comp (fnil identity -1) solve))

;; @code end

